# Claude / devcontainer / gtags を emacs から使う

openpilot を emacs で扱うためのセットアップの使い方まとめ。
設定は `emacs29.el`(/`emacs30.el`) と業務ローカルの `personal.el` に入っている。
端末は **vterm**（要ビルド: libvterm）。eat/term.el は claude TUI で不可だったため不採用。

---

## 0. 反映方法

- `personal.el` だけ変えたとき: `M-x load-file RET ~/.emacs.d/personal.el RET`
- `emacs29.el`/`emacs30.el` を変えたとき: emacs を再起動（起動時にしか読まれない）

---

## 1. Claude / Devin / Codex を起動する（vterm）

| 用途 | コマンド | バッファ名 |
|---|---|---|
| ホスト上の任意プロジェクト | `M-x my/claude`（`C-u` で別セッション） | `*claude:local*` |
| ホスト上で Devin CLI | `M-x my/devin`（`C-u` で別セッション） | `*devin:local*` |
| ホスト上で Codex CLI | `M-x my/codex`（`C-u` で別セッション） | `*codex:local*` |
| ローカル op コンテナ | `M-x my/openpilot-claude` | `*claude:op*` |
| リモート機の op コンテナ | `M-x my/remote-claude` →ホスト名入力 | `*claude:<host>*` |

- ローカル/ホスト版は project ルート（無ければ default-directory）が作業ディレクトリ。
- 起動コマンドを変えたい場合の変数:
  - ホスト用: `my/claude-program`（既定 `"claude"`）/ `my/devin-program`（既定 `"devin"`）/ `my/codex-program`（既定 `"codex"`）
  - ローカル op 用: `my/openpilot-claude-command`（既定 `docker exec -it -w /tmp/openpilot op claude`）
  - リモート用 claude フルパス: `my/remote-claude-path`（既定 `/home/batman/.local/bin/claude`）
- Devin / Codex も Claude と同じ vterm + `bash -lc` 方式（`my/vterm--ai-launch` 共通部）。
  日本語入力（下記コンポーズバッファ）もそのまま使える。

### 日本語入力（mozc）

vterm は read-only で mozc.el を inline 直接入力できない（構造的制約）。代わりにコンポーズバッファを使う:

1. vterm バッファで **`C-c C-j`** または **`s-SPC`** → `*vterm-compose*` が開く（mozc 自動 ON）
2. 普通の編集バッファなので **mozc inline・複数行・長文** で自由に書く（`s-SPC` で和英切替）
3. **`C-c C-c`** で全文を claude へ bracketed paste 送信（改行で勝手に確定しない）。元の vterm に戻る
4. 内容を確認して **RET** で claude に実行（破棄は **`C-c C-k`**）

- すでに変換済みのテキストは `C-y`（`vterm-yank`）で貼っても送れる。
- vterm 内で IME が ON になって read-only で詰むのは安全網が自動 OFF に戻す。
  万一詰まったら `M-x toggle-input-method`。

---

## 2. dev container を CLI から使う（@devcontainers/cli）

VSCode 不要で devcontainer のライフサイクルを回す。要 `npm i -g @devcontainers/cli`（nvm なので sudo 不要）。

| 操作 | コマンド |
|---|---|
| カレントプロジェクトの dev container を起動 | `M-x my/devcontainer-up` |
| カレントプロジェクトのコンテナ内に vterm シェル（devcontainer exec） | `M-x my/devcontainer-shell` |
| openpilot を（プロジェクト外からでも）起動 | `M-x my/openpilot-devcontainer-up` |
| openpilot のコンテナ内に vterm シェル | `M-x my/openpilot-devcontainer-shell` |
| openpilot のワークスペースを dired で開く（/docker: TRAMP）＋gtags 用意 | `M-x my/openpilot-open` |

- `my/devcontainer-up` / `my/devcontainer-shell` は汎用（公開側 emacs2X.el）。プロジェクトルートの
  `devcontainer.json`（`.devcontainer/devcontainer.json` / `.devcontainer.json` /
  `.devcontainer/<name>/devcontainer.json`）を自動検出し、複数あれば選択を求める
  （例: aurora-ltfs の rocky9 / ubuntu2404、openpilot の openpilot / openpilot-ui）。
- openpilot 用ラッパ（personal.el）はパスと設定を決め打ちしただけ。設定切替は
  `my/openpilot-devcontainer-config`（既定 openpilot。UI は `.devcontainer/openpilot-ui/devcontainer.json`）
- `devcontainer up` は initializeCommand も走るので、openpilot では手動 `docker start` で抜ける
  `.env`(BASE_COMMIT) や Xauthority も正しく整う。

---

## 3. gtags タグジャンプ

emacs 側は設定変更不要（apt の `gtags.el` が process-file ベースで TRAMP 対応）。
DB はコンテナ側の global で生成する（ホストと非互換のため）。`my/openpilot-open` 時に
`my/openpilot-ensure-gtags` が冪等で「global 無→apt 導入 / GTAGS 無→生成」する。

| キー | 動作 |
|---|---|
| `M-t` | 定義へジャンプ（find-tag） |
| `M-r` | 参照を検索（find-rtag） |
| `M-s` | シンボル検索 |
| `C-t` | ジャンプ元へ戻る（pop-stack） |

---

## 4. リモートのターゲット機（本番 Jetson, *.local）

対象ホスト例: `eac-NN.local` / `orindev-NN.local` / `thordev-NN.local` / `eac7k-NN.local` /
`drivethor-NN.local`。どれも openpilot コンテナは **container_name=op**
（`td.sh dev --skip-check-all` で起動）。**リモートの op には claude も GNU Global も
入っていない**ので、初回に自己修復で導入する。

| 操作 | コマンド |
|---|---|
| 初回1回: global+GTAGS と claude を導入 | `M-x my/remote-ensure` →ホスト名入力 |
| claude を起動 | `M-x my/remote-claude` |
| コンテナ内シェル | `M-x my/remote-shell` |
| ワークスペースを dired（多段 TRAMP）＋ensure | `M-x my/remote-open` |

- ホスト名は履歴付き入力（例 `eac-12.local`）。前回値をすぐ呼べる。
- ssh ユーザが既定と違うときだけ `my/remote-ssh-user` を設定（既定 nil = ~/.ssh/config 委譲）。
- `my/remote-ensure` は `*remote-ensure*` バッファに進捗を出す。本番コンテナに
  `sudo apt`(global) と `curl | bash`(claude 公式インストーラ→`~/.local/bin`) を走らせる。
- 編集は `/ssh:<host>|docker:batman@op:/tmp/openpilot/` の多段 TRAMP。gtags.el も多段越しに効く。

---

## 設計メモ（なぜこうなっているか）

- **端末は vterm 一択**: eat は claude の TUI で emacs 全体が固まり、内蔵 term.el は画面が崩れた。
  libvterm を使う vterm のみ正しく描画。eat は無ビルドの汎用端末として残置（claude には使わない）。
- **コンテナ/リモートで TRAMP の make-process を使わない**: TRAMP は同期実行で、リモート shell が
  返らないと emacs 全体がフリーズする。claude/シェルは「ローカル vterm に `docker exec -it` /
  `ssh -t … docker exec -it` を直結」する。編集の TRAMP（dired/gtags）は通常どおり使ってよい。
- **ssh の二重パース回避**: vterm(ローカル sh)→ssh→remote shell と2回パースされるので、複雑な
  `bash -c` スクリプトを vterm-shell に埋めると壊れる。claude 起動はフルパスでクォート無し、
  自己修復導入は make-process の素 argv による単段 ssh で行う。
- **login shell(`bash -lc`)を避ける**: コンテナの profile がハングする事例があったため、
  自己修復は `bash -c`（profile 不使用）で行う。

設定の所在: 汎用(vterm/my-claude/日本語入力) = `emacs29.el`/`emacs30.el`、
openpilot/リモート固有 = `personal.el`。
