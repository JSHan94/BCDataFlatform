# BCDataFlatform

## 실행방법

web3.py 호환성 문제로 인해 반드시 python3.6 버전을 사용할것. 3.5 나 3.7버전일시 web3.py 설치시 에러발생

1. 가상환경(virtualenv) 세팅. 없을경우 virtualenv -m 

```python
virtualenv myenv
source myenv/bin/activate
pip install -r requirements.txt
```

2. 파이썬 코드에서 실행하고 싶은 모듈 주석 처리 푼 다음 실행

```python
python3 trading.py
```
