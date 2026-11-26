# konpota-3d（コンポタマスター 3D）

コンポタを作り、最強のコンポタ師を目指す、1人称視点・縦型（720×1280）の3D料理シミュレーションゲームです。

キッチンの定位置に立ち、スワイプで見回し、ステーションをタップしてズームインします。材料や器具をドラッグして調理し、カウンター越しの客にコンポタを提供します。

仕様は [`SPEC.md`](SPEC.md)、開発ルールは [`AGENT.md`](AGENT.md) を参照してください。

## 開発環境

- Godot: `4.7.2.stable.official.ed1daf0bf`
- レンダラー: Compatibility
- 画面: 縦型（ポートレート）720×1280
- 3D物理エンジン: Jolt Physics
- バージョン管理: Git / GitHub
- 対応開発環境
  - macOS（Apple Silicon）
  - Windows

> プロジェクトの互換性を保つため、原則として上記と同じGodotバージョンを使用してください。

## 開発の始め方

### 1. リポジトリをクローンする

```bash
git clone git@github.com:yuba-don/konpota-master-3d.git
cd konpota-master-3d
git lfs install
git lfs pull
```

HTTPSを使用する場合:

```bash
git clone https://github.com/yuba-don/konpota-master-3d.git
cd konpota-master-3d
git lfs install
git lfs pull
```

### 2. Godotでプロジェクトを開く

1. Godot Project Managerを起動する
2. **Import**を選択する
3. クローンしたディレクトリ内の`project.godot`を選択する
4. **Import & Edit**を選択する

コマンドラインから開く場合:

```bash
godot --editor --path .
```

初回起動時はアセットのインポートに時間がかかる場合があります。

## Git運用

`main`へ直接プッシュせず、作業用ブランチを作成してください。

```bash
git switch main
git pull
git switch -c feature/player-movement
```

作業後:

```bash
git add .
git commit -m "Add player movement"
git push -u origin feature/player-movement
```

GitHubでPull Requestを作成し、レビュー後に`main`へマージします。

### ブランチ名

| 接頭辞     | 用途         | 例                        |
| ---------- | ------------ | ------------------------- |
| `feature/` | 新機能       | `feature/player-movement` |
| `fix/`     | バグ修正     | `fix/player-collision`    |
| `docs/`    | ドキュメント | `docs/update-readme`      |

## Godotでの共同開発ルール

### シーンとリソースの同時編集を避ける

Godotのシーン（`.tscn`）やリソース（`.tres`）はテキスト形式ですが、複数人が同時に編集するとコンフリクトが発生することがあります。

- 担当するシーンを分ける
- 大きなシーンは小さなシーンに分割する
- 共通要素は別シーンやリソースとして切り出す
- 作業開始前に`main`の最新状態を取り込む

### Godot関連ファイルをまとめてコミットする

スクリプト、シーン、リソース、元アセットに加えて、Godotが作成した`.uid`や`.import`ファイルがある場合は、関連する変更をまとめてコミットしてください。

主な管理対象:

```text
*.gd       GDScript
*.tscn     シーン
*.tres     リソース
*.godot    プロジェクト設定
*.uid      リソースUID
*.import   インポート設定
```

### プロジェクト設定はGodot Editorから変更する

`project.godot`は、原則としてGodot Editorの **Project > Project Settings** から変更してください。変更後は意図しない設定差分が含まれていないか確認します。

## 大容量アセット

画像・音声・動画などの大容量ファイルを追加する場合は、事前にチームへ共有してください。

画像・音声・フォント・3Dモデルなどの大容量アセットはGit LFSで管理しています（対象の拡張子は`.gitattributes`を参照）。クローン後に`git lfs install`を一度実行してください。新しい拡張子のアセットを追加する場合は、先に`.gitattributes`へ追加してからコミットします。

## APIキー・秘密情報

APIキー、アクセストークン、パスワードなどをGitHubへプッシュしないでください。

秘密情報を保存するファイル（例: `.env`）は`.gitignore`へ追加します。誤って公開した場合は、ファイルを削除するだけでなく、すぐにチームへ共有してキーを無効化してください。

## その他

開発ルールは、プロジェクトの進行に合わせて随時更新します。
