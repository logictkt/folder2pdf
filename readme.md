# Folder2PDF
フォルダの中身の画像をまとめてPDFに変換する

## 使い方
```
cd folder2pdf
ruby main.rb folder_path folder_path folder_path
```

> folder_pathのコピーは面倒なので、FinderからD&Dすると楽。

## Folder構造について
```
- folder_1
  - image1.jpg
  - image2.jpg
  - image3.jpg
- folder_2
  - folder_3
    - image4.jpg
    - image5.jpg
    - image6.jpg
  - folder_4
    - image7.jpg
    - image8.jpg
    - image9.jpg
```

このような状態なら処理可能

実行後は下記のようなPDFファイルが作成される

```
- folder_1.pdf
- folder_2
  - folder_3.pdf
  - folder_4.pdf
```