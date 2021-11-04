# Smile Blog😀

> Smile Blog : 웃고 삽시다 😀 



## Index
- [기능 및 소개](#기능-및-소개)
- [설계 및 구현](#설계-및-구현)
- [Trouble shooting](#Trouble-shooting)

## 기능 및 소개
- [메인 페이지](#메인-페이지)
- [글 등록](#글-등록)
- [글 수정 및 삭제](#글-수정-및-삭제)
- [댓글 기능](#댓글-기능)

### 메인 페이지
> 사용자의 배경 화면과 블로그 글 리스트를 확인할 수 있다.
> 
> keyword: UITableView, CustomView

<img src = "https://user-images.githubusercontent.com/57824307/140412686-a222b1c9-120b-4700-8a90-e5cd6dd96f99.gif" width = 220>

### 글 등록
> TabBarController를 통한 모달 뷰 전환 후 새 글 작성을 할 수 있다.
> 입력해야할 항목이 전부 작성되어야 등록이 가능하다.
> 글이 작성되거나, 취소되면 이전 화면으로 전환된다.
> 
> keyword: UITabBarController-Modal, DB Query

||새 글 쓰기|일부 미입력 시|화면 전환|
|:-:|:-:|:-:|:-:|
|<img src = "https://i.imgur.com/yKjiv5G.gif" width = 220>|<img src = "https://i.imgur.com/yGmMdj8.png" width = 220>|<img src = "https://i.imgur.com/7PPfqZr.png" width = 220>|<img src = "https://i.imgur.com/9ApfaXj.png" width = 220>|

### 글 수정 및 삭제
> 네비게이션 바 버튼을 통해 글을 수정하거나 삭제할 수 있다.
> 
> 수정 시엔 게시글 뷰 전환되고, 삭제 시엔 게시글 리스트로 화면이 전환된다.
> 
> keyword: Notification Center, 비동기 프로그래밍, DB Query


||수정 요청|글 수정 화면|완료 시 화면 전환|
|:-:|:-:|:-:|:-:|
|<img src="https://i.imgur.com/vajCc19.gif" width=220>|<img src = "https://i.imgur.com/ja0PZ53.png" width = 220>|<img src = "https://i.imgur.com/k6zJ7AX.png" width = 220>|<img src = "https://i.imgur.com/cZVIHtS.png" width = 220>|
||**삭제 요청**|**요청 시 얼럿 뷰 띄움**|**완료 시 화면 전환**|
|<img src="https://i.imgur.com/3a1pKB7.gif" width=220>|<img src = "https://i.imgur.com/a16k7vE.png" width = 220>|<img src = "https://i.imgur.com/QNDvQwo.png" width = 220>|<img src = "https://i.imgur.com/9aNSWhE.png" width = 220>|

### 댓글 기능
> 선택된 포스트에 댓글을 쓸 수 있다.
> 
> keyword: NotificationCenter, ScrollView, DB Query


||키보드 ON|키보드 OFF|댓글 등록|
|:-:|:-:|:-:|:-:|
|<img src="https://i.imgur.com/un5gVYf.gif" width=220>|<img src = "https://i.imgur.com/ub6Gxa9.png" width = 220>|<img src = "https://i.imgur.com/jq1Fqmq.png" width = 220>|<img src = "https://i.imgur.com/eFhlylR.png" width = 220>|



## 설계 및 구현

### **프로젝트 구현 사항**
---
|Project|Smile Blog|
|:--:|:--:|
|UI 구현 | UIKit |
|아키텍쳐 | MVC |
|로컬 데이터 저장소|SQLite|

#### 👉 UML
![UML](https://i.imgur.com/PG3LrFC.png)
###### UML 내 뷰의 구성 요소는 제외.


<br>

#### 👉 데이터 Flow
블로그 서비스는 실제 서버로부터 데이터를 수신하는 과정이 요구되기 때문에 서버가 구현되진 않았으나, **실제 서버 구축이 될 것임을 고려**하여, 데이터 요청을 위한 과정을 미리 구현했다.

허나 MOCK을 사용한 통신 로직을 구현하더라도 실제 통신 없이는 블로그 글에 대한 CRUD가 어렵다고 판단이 되어, 
데이터 요청을 대체하기 위해 **로컬 데이터 베이스**를 활용했다.
1. **데이터베이스 선택**
>    - sqlite3 [O]
>    - coreData [X]
 
 
=> **SQLite**
    
선정 기준
-  CoreData를 활용한 프로젝트 경험 ⭕️
    따라서 SQLite도 사용해보고 싶었다. 쿼리문을 직접 다루는 SQLite 사용해 DB를 구성.
    내부적으로 SQLite 사용하는 것은 동일하지만, 직접 쿼리문을 작성해야 한다! ~~이번 기회에 많이 다뤄보자!~~
     

2. **데이터베이스 설계**
  - **Post Table**

    |column|내용|속성|
    |---|---|---|
    |post_num|글 번호 저장 / AutoIncrease|INTEGER|
    |post_title|글 제목 저장|TEXT|
    |post_content|글 내용 저장|TEXT|
    |post_date|글 작성 날짜 및 시간 저장|TEXT|


  - **comment Table**
    |column|내용|속성|
    |---|---|---|
    |comment_num|댓글 번호 저장 / AutoIncrease|INTEGER|
    |comment_user|댓글 작성자 저장|TEXT|
    |comment_post|댓글이 작성된 글 post_num 저장 |INTEGER|
    |comment_content|댓글 내용 저장|TEXT|
    |comment_date|댓글 작성 날짜 및 시간 저장|TEXT|
        
    
#### 👉 아키텍쳐

**MVC(Model-View-Controller)**

MVC 구조로 작성할 경우, ViewController가 하는 역할이 많아지는데(~~Massive View Controller~~) 
해당 구조에서 최대한 중복 코드를 줄이기 위해 공통된 구현의 경우, Protocol의 Extension을 활용했다.


#### 👉 레이아웃 구성
- **코드를 활용한 레이아웃 구성**

    => `협업 시` 인터페이스 빌더의 사용으로 생길 수 있는 코드 간 충돌을 만들 수 있는 단점 보완하기 위함.


#### 👉 디렉토리 구성 및 역할

#### Scene
|         protocol             |                             역할                             |
| :--------------------------: | :----------------------------------------------------------:|
|    `ViewConfiguration`       | ViewController에서 채택 후 뷰의 계층, 제약, 설정을 하도록 함. |
|    `PostReloadable`          | Post를 가진 일부 ViewController에서 채택 후 MainView 내 테이블뷰 Reload 요청. |

|            class             |                             역할                             |
| :--------------------------: | :----------------------------------------------------------: |
|    `IntroduceCell`           | MainViewController에서 블로그 소개 셀을 구성 |
|    `MainTableViewCell`       | MainViewController에  블로그 포스트 셀을 구성 |
|    `DetailViewContentCell`   | DetailViewController 내 블로그 글을 구성 |
|    `DetailViewCommentCell`   | DetailViewController 내 블로그 댓글을 구성 |

|            class              |                             역할                             |
| :--------------------------:  | :----------------------------------------------------------: |
|    `MainTabBarController`     | 탭 바 구성 |
|    `MainViewController`       | 블로그 포스트 리스트 화면 구성 |
|    `NewPostViewController`    | 새 글 작성 화면 구성  |
|    `DetailViewController`     | 포스트 화면 구성 |
|    `UpdatePostViewController` | 포스트 수정 화면 구성 |
|    `UserSettingViewController`| 사용자 화면 구성(미구현) |


#### Model
|     struct      |                             역할                             |
| :-------------------: | :----------------------------------------------------------: |
|   `Post`              | 글 구성 |
| `Comment`             | 댓글 구성 |


#### Module
|     class             |                             역할                             |
| :-------------------: | :----------------------------------------------------------: |
|   `FMDBManager`       | SQLite 데이터베이스와 연결 후, 데이터 CRUD |


<br>


#### 👉 의존성 관리 도구 사용

CocoaPod
- [swiftLint] : 코드 컨벤션을 위해 사용

SPM(Swift Package Manager)
- [FMDB](https://github.com/ccgus/fmdb) : DB 구성을 위해 사용
    - 내부적으로 SQLite3를 사용.


## Trouble shooting

#### 1. 모달 뷰의 부재
Navigation Controller1 - (root 1) -> View Controller A -(modal)-> Navigation Controller 2 -(root 2)-> View Controller B(UIVIewController) 의 과정으로 모달을 띄우는 과정에서 root 2에 해당하는 navigation Controller에서 navigation Item이 제대로 출력되지 않는 모습을 확인할 수 있었다. View Controller B를 Navigation Controller 2를 root로 감싸줬음에도 불구하고 제대로 출력이 되지 않아서 당황했다.

|문제 상황|원하는 모습|
|:-:|:-:|
|<img src="https://i.imgur.com/tdBH52P.png" height=200>|<img src="https://i.imgur.com/eH6mvo9.png" height=200>|


네비게이션2를 모달로 띄울 때, View Controller B에서는 NavigationBar이 나오질 않는데 해결 방법

새 글을 작성하는 뷰는 새로운 흐름을 가져가야하는데, 기존 네비게이션 스택을 활용하는 방법은 뷰의 구성에서 일관성을 해칠 수 있다고 생각해 modal 뷰로의 구현을 생각했음.
하지만 본 모달은 앱에서 새 글 작성 외에 타 기능을 하지 않기 때문에 위의 상황을 뷰에 직접 네비게이션 바를 생성해주는 방식을 활용해 뷰를 구성했다.
[Modal 제대로 뜨지 않는 문제와 관련 참고 링크](https://coderedirect.com/questions/159282/modal-segue-navigation-bar-disappears)


#### 2. 키보드에 의한 텍스트뷰 가려짐

본문의 내용이 길어질 경우, 하단의 키보드 영역에 의해 본문의 영역이 제대로 보이지 않는 문제가 발생.
키보드가 올라와 있는 경우, NotificationCenter을 활용해 해당 텍스트 뷰의 최하단이 키보드보다 위로 올라갈 수 있도록 설정했다.
또한 키보드가 내려가는 상황엔 이와 반대로 텍스트 뷰가 다시 부모 뷰의 최하단 영역과 동일한 레이아웃 제약 값을 가지도록 했다.
|문제 상황|해결 상황|
|:-:|:-:|
|![키보드 이슈](https://i.imgur.com/faQwu2B.gif)|![키보드 이슈 해결](https://i.imgur.com/QZvrWWo.gif)|

글 작성, 수정, 댓글 작성 모두 키보드에 의한 레이아웃 변경이 일어나야 해서 여러 상황을 많이 경험할 수 있었다. 
하지만 NotificationCenter을 사용할 경우, Listener 모두에게 전달되는 점을 고려하면 너무 많이 사용될 경우, 코드 점핑이 많이 발생할 수 있어 delegate Pattern도 고려해봐야겠다.




