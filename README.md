<div>
  <img src="https://capsule-render.vercel.app/api?type=soft&color=0:fffdfd,100:ffeeF6&height=100&text=🚄%2037%20COLLABORATION%20iOS%20KORAILTALK%20🍎&animation=&fontColor=000000&fontSize=40" />
</div>


> 37기 DIVE SOPT 합동 세미나 모바일 앱 1조 코레일톡 아요 🚅

###  iOS Developer
|    선영주   |    공수민   |   어재선   |    한현서    |
| :-------------: | :----------: | :----------: |:----------: |
| <img src = "https://github.com/dudwntjs.png" width ="200"> | <img src = "https://github.com/sum130.png" width ="200">  | <img src = "https://github.com/wotjs020708.png" width ="200"> | <img src = "https://github.com/hyunseo-han.png" width ="200"> | 
|   `iOS Lead` |    `iOS Developer`   |  `iOS Developer`    |    `iOS Developer`   |
| 결제, 쿠폰 적용, 결제 바텀시트 | 국가유공자 할인, 예약 바텀시트·모달, 네비 바 | 열차 조회, Base 뷰 | 홈, 탭바 |


### 🎬 시연 영상

|   홈   |   열차조회  |   결제-할인쿠폰적용  |   결제-국가유공자 할인적용  |
| :----------: | :----------: | :----------: | :----------: |
| <img src = "https://github.com/user-attachments/assets/66e632d7-0de0-4127-999d-0071fec9f845" width ="250"> | <img src = "https://github.com/user-attachments/assets/7d9793cd-f2fa-4839-9fb3-40cf37c11adf" width ="250"> | <img src = "https://github.com/user-attachments/assets/1581627c-93f4-4b2f-b947-a3546e0ca575" width ="250"> | <img src = "https://github.com/user-attachments/assets/3d6e15cb-16fa-4abe-bbc7-90785bcb03ac" width ="250"> |


### 📁 프로젝트 구조
```
├── 📁 Application
│   ├── 📃 AppDelegate.swift
│   ├── 📃 AppFactory.swift
│		└── 📃 SceneDelegate.swift
├── 📁 Global
│   ├── 📁 Base
│   ├── 📁 Components
│   ├── 📁 Enums
│   ├── 📁 Extensions
│   ├── 📁 Protocols
│   └── 📁 Resources
│       ├── 📃 Assets.xcassets
│       └── 📁 Fonts
├── 📁 Network
│   ├── 📁 Base
│   ├── 📁 DTO
│   │   ├── 📁 RequestDTO
│   │   └── 📁 ResponseDTO
│   ├── 📁 Logger
│   ├── 📁 Service
│   └── 📁 TargetType
├── 📁 Presentation
│   ├── 📁 Home
│   │   ├── 📁 Model
│   │   ├── 📁 View
│   │   └── 📁 ViewController
│   └── 📁 Reservation
│       ├── 📁 Components
│       ├── 📁 Model
│       └── 📁 View
└── 📃 Info.plist
└── 📃 ViewController
```


### ⚒️ 기술 스택
| 태그       | 설명                                                   |
|------------|--------------------------------------------------------|
| `UI 프레임워크`     | UIKit                                       |
| `버전 관리`     | Git, GitHub                                |
| `협업 도구`      | Figma, Notion                                      |



### ‼️ Commit Message 규칙
#### 태그 컨벤션

| 태그       | 설명                                                   |
|------------|--------------------------------------------------------|
| `init`     | 가장 처음 Initial Commit에 태그 붙이기                                       |
| `feat`     | 새로운 기능 구현 시 사용                                |
| `fix`      | 버그나 오류 해결 시 사용                                      |
| `docs`     | README, 템플릿 등 프로젝트 내 문서 수정 시 사용                                  |
| `setting`  | 프로젝트 관련 설정 변경 시 사용                            |
| `add`      | 사진 등 에셋이나 라이브러리 추가 시 사용                                   |
| `refactor` | 기존 코드를 리팩토링하거나 수정할 시 사용              |
| `chore`    | 별로 중요한 수정이 아닐 시 사용                          |
| `hotfix`   | 긴급 수정 |

---

#### 커밋 컨벤션

1. 태그는 반드시 **소문자**로 작성합니다.  
2. 내용은 **한글**로 작성합니다.  
3. 제목은 **50자**를 넘지 않도록, 간단하게 **명령조**로 작성합니다.
4. 설명이 필요한 경우 **description**에 작성합니다.

```markdown
(기본 커밋 메세지)
[feat/#1] 로그인 기능 구현

(원격 develop → 로컬 develop merge)
[merge/#1] pull develop

(원격 develop merge)
[merge/#1] feat/#1 -> develop

(충돌 해결)
[conflict/#1] 충돌 해결  
```

#### 브랜치 컨벤션

```markdown
feat/#1-loginUI
add/#3-assetsSetting
refactor/#53-LoginViewRefacto
