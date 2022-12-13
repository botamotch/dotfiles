# Firefoxユーザースタイルシート作成手順

- `about:config`を開く。

  - 警告が出る場合『危険性を承知の上で使用する』をクリック

- `toolkit.legacyUserProfileCustomization.stylesheets`を`true`に変更する

- `.mozilla/firefox/{your-profile}/chrome/`フォルダを作成する

  - `Chrome`だと駄目

- `userContent.css`, `userChrome.css`を作成する

```
$ ln -s ~/Git/dotfiles/Firefox/userContent.css .
$ ln -s ~/Git/dotfiles/Firefox/userChrome.css .
```

https://www.bbc.com のCookie同意画面を消去するためにユーザースタイルシートを使用することを検討中。

まだよくわかんないことがあるけど一応外観が変わったのでもう少し試していけばなんとかなりそう。

