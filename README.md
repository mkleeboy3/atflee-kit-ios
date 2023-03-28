# Atflee iOS Kit
앳플리 블루투스 연결 인터페이스를 커스텀 구현한 라이브러리

## 주의사항
#### 이 프레임워크는 git-lfs를 사용합니다. 배포자는 아래 링크에 들어가서 git-lfs 설치를 바랍니다.
[git-lfs official](https://git-lfs.com/)

## xcframework 배포
#### build 폴더로 지원하려는 기기에 맞게 archive 한다.
```sh
xcodebuild archive \
  -scheme AtfleeKit \
  -archivePath './build/ios.xcarchive' \
  -sdk iphoneos \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES # iOS
```

#### 현재 디렉토리에 xcframework 생성
```sh
xcodebuild -create-xcframework \
  -framework "./build/ios.xcarchive/Products/Library/Frameworks/AtfleeKit.framework" \
  -output "./AtfleeKit.xcframework"
```

## podspec 관리
#### 프로젝트에 podspec 파일이 반드시 존재해야하고, 업데이트 시에 podspec 파일도 업데이트 해야한다.
```ruby
Pod::Spec.new do |s|
  s.name             = 'AtfleeKit'
  s.version          = '0.0.1' # 업데이트가 있을 시 반드시 버전을 올려야 한다
  s.summary          = 'Atflee bluetooth interface for iOS'

  s.description      = <<-DESC
  Atflee bluetooth interface for iOS  
                       DESC

  s.homepage         = 'https://github.com/huraypositive/atflee-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mkleeboy3@huray.net' => '...' }
  s.source           = { :git => 'https://github.com/huraypositive/atflee-kit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.vendored_frameworks = 'AtfleeKit.xcframework' # 프레임워크 별도 의존성 설정 없이, plug-and-play를 위함
end
```

#### 업데이트를 remote에 push한 이후, tag로 버전 관리를 한다.
```sh
git add .
git commit -m "[{COMMIT_PREFIX}] {내용}"
git push

git tag {version} # 버전은 podspec에 명시된 버전과 일치하여야 한다
git push origin {version}
```

#### 업데이트 이후에, podspec 파일을 '휴레이 podspecs 저장소'에 푸쉬한다.
```sh
cp ./AtfleeKit.podspec {directory_to_podspecs_repo_clone}/AtfleeKit/{version}

# 디렉토리 이동: {directory_to_podspecs_repo_clone}

git add .
git commit -m "[ADD] AtfleeKit {version}"
git push
```

## 설치 커맨드
```sh
# 프로젝트 루트 디렉토리에서
pod repo update
pod install

# 최신 버전의 라이브러리로 업데이트하고 싶은 경우
pod update
```

## 사용 방법

## 블루투스 사용 권한 및 안내 메세지 추가
- XCode > 디렉토리에서 프로젝트 선택 > TARGETS > Info 에서 다음 추가
  - Privacy - Bluetooth Always Usage Description
  - Privacy - Bluetooth Peripheral Usage Description

## 라이브러리 의존성 추가
- XCode > TARGETS에서 프로젝트 선택 > General > Frameworks, Libraries, and Embedded Content 에서 다음 추가
  - libc++.tbd
  - libz.tbd

## 기기 스캔 및 등록 (Register)
#### 앱 시작 시 AtfleeManager 객체 초기화
```swift
private let _ = AtfleeManager.shared
```
* AtfleeManager 인스턴스는 싱글톤이다

#### ViewModel에서 AtfleeManager의 Publisher를 담을 변수를 생성한다.
```swift
class MainViewModel: ViewModelProtocol {
  private let manager = AtfleeManager.shared
  
  @Published var scannedDevices: [AtfleeDevice] = []
  @Published var bluetoothState: AtfleeBluetoothStateType = .unknown
  @Published var scanState: AtfleeScanStateType = .notScanning
  @Published var connectionState: AtfleeConnectionStateType = .disconnected
  @Published var measurementState: AtfleeMeasurementStateType = .idle
  @Published var measurement: AtfleeWeightMeasurement?
  
  private var cancellables = Set<AnyCancellable>()
}
```

#### Publisher를 이용하여 적절하게 View를 업데이트 시켜준다.
```swift
class MainViewModel: ViewModelProtocol {
  ...

  init() {
    subscribeToBluetoothStatePublisher()
    subscribeToScanStatePublisher()
    subscribeToScannedDevicesPublisher()
    subscribeToConnectionStatePublisher()
    subscribeToMeasurementStatePublisher()
    subscribeToWeightMeasurementPublisher()
  }
  
  private func subscribeToBluetoothStatePublisher() {
    manager.bluetoothStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.bluetoothState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToScanStatePublisher() {
    manager.scanStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.scanState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToScannedDevicesPublisher() {
    manager.scannedDevicesPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] devices in
        self?.scannedDevices = devices
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToConnectionStatePublisher() {
    manager.connectionStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.connectionState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToMeasurementStatePublisher() {
    manager.measurementStatePublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        self?.measurementState = state
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToWeightMeasurementPublisher() {
    manager.weightMeasurementPublisher
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { errorType in
        print("error")
      }, receiveValue: { [weak self] measurement in
        self?.measurement = measurement
      })
      .store(in: &cancellables)
  }
  
  func startScan() {
    do {
      try manager.startScan()
    } catch let atfleeError as AtfleeErrorType {
      print("atfleeErrorType: \(atfleeError)")
    } catch let commonError {
      print("\(commonError)")
    }
  }
  
  func stopScan() {
    manager.stopScan()
  }
  
  func connectToDevice(_ device: AtfleeDevice) {
    do {
      try manager.connectToDevice(device)
    } catch let atfleeError as AtfleeErrorType {
      print("atfleeErrorType: \(atfleeError)")
    } catch let commonError {
      print("\(commonError)")
    }
  }
  
  func disconnect() {
    manager.disconnect()
  }
}
```

## AtfleeManager 인터페이스
### 스캔 상태 스트림
```swift
public var scanStatePublisher: AnyPublisher<AtfleeKit.AtfleeScanStateType, Never> { get }
```

### 연결 상태 스트림
```swift
public var bluetoothStatePublisher: AnyPublisher<AtfleeKit.AtfleeBluetoothStateType, Never> { get }
```

### 스캔된 디바이스 데이터 스트림 (스캔한 모든 디바이스를 배열로 반환)
```swift
public var scannedDevicesPublisher: AnyPublisher<[AtfleeKit.AtfleeDevice], Never> { get }
```

### 스캔 시작
```swift
public func startScan(timeoutInSeconds: Int = 30) throws
```

### 기기 연결
```swift
public func connectToDevice(_ device: AtfleeDevice) throws
```

### 체중기록 스트림 (모든 기록 다 가져옴)
```swift
public var weightMeasurementPublisher: AnyPublisher<AtfleeKit.AtfleeWeightMeasurement, AtfleeKit.AtfleeErrorType> { get }
```

### 스캔 중지
```swift
public func stopScan()
```

### 연결 해제
더이상 SDK를 사용하지 않거나 혹은 즉시 연결을 끊어야 할 때 호출한다. 모든 스트림의 데이터를 초기화한다.
```swift
public func disconnect()
```

### 앳플리 사용자 model
```swift
public struct AtfleeUser {

    public let index: UInt

    public let nickName: String

    public let height: UInt

    public let weight: Double

    public let age: UInt

    public let gender: AtfleeUserGenderType
}
```

### 앳플리 디바이스 model
```swift
public struct AtfleeDevice {

    public let name: String

    public let macAddress: String

    public let rssi: Int
}
```

### 체중 기록 model
```swift
public struct AtfleeWeightMeasurement {

    public let weight: Double

    public let bodyFatPercent: Double

    public let subcutaneousFatPercent: Double

    public let visceralFat: Double

    public let ffm: Double

    public let musclePercent: Double

    public let muscleMass: Double

    public let bmr: Int
}
```

### 에러 model
```swift
public enum AtfleeErrorType : Error {

    case bluetoothUnavailable // 블루투스가 꺼져 있는 경우

    case connectionInProgress // 연결 도중 connectToDevice 함수를 호출한 경우
}
```