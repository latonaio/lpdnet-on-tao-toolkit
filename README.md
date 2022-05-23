# lpdnet-on-tao-toolkit
lpdnet-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて LPDNet の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- LPDNet
- Docker
- TensorRT Runtime

## LPDNetについて
LPDNet は、画像内のナンバープレートを検出し、カテゴリラベルを返すAIモデルです。  
LPDNet は、特徴抽出にResNet18を使用しており、混雑した場所でも正確に物体検出を行うことができます。

## 動作手順

### engineファイルの生成
LPDNet のAIモデルをデバイスに最適化するため、ResNet18 における LPDNet の .etlt ファイルを engine file に変換します。
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
        docker exec -it lpdnet-tao-toolkit tao-converter -k nvidia_tlt -p Input,1x3x480x640,4x3x480x640,16x3x480x640 \
                -t fp16 -d 3,480,640 -e /app/src/lpdnet_usa.engine /app/src/usa_pruned.etlt
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された LPDNet の AIモデルを Deep Stream 上で動作させる手順は、[lpdnet-on-deepstream](https://github.com/latonaio/lpdnet-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである lpdnet_usa.engine は、[lpdnet-on-deepstream](https://github.com/latonaio/lpdnet-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  
