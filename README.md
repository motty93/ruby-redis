## ruby redis
### 前準備
※redis cloudのアカウントを作成し、env_sampleを参考にREDIS_URLを設定する
```bash
docker build -t ruby-redis .
```

### 実行
```bash
docker run -it --rm ruby-redis bundle exec ruby get_value.rb
```
