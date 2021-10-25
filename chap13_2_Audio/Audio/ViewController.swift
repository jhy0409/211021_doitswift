//
//  ViewController.swift
//  Audio
//
//  Created by inooph on 2021/10/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer! // AVAudioPlayer 인스턴스 변ㅅ
    var audioFile : URL! // 재생할 오디오의 파일명 변수
    let MAX_VOLUME: Float = 10.0 // 최대볼륨, 실수형 상수
    var progressTimer: Timer! // 타이머를 위한 변수
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    
    let timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)
    
    // MARK: - [ㅇ] 현재재생 구간, 재생시간, 전체시간
    @IBOutlet weak var pvProgressPlay: UIProgressView!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    
    // MARK: - [ㅇ] 재생, 일시정지, 정지
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var slVolume: UISlider!
    
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblRecordTime: UILabel!
    
    // MARK: - [ㅇ] 녹음 관련
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        selectAudioFile()
        if !isRecordMode { // 녹음X -> 재생모드일 때
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else { // 녹음모드
            initRecord()
        }
    }
    
    // MARK: - [ㅇ] 녹음모드 여부에 따른 url분기
    func selectAudioFile() {
        if !isRecordMode { // 재생모드
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else { // 녹음모드
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    // MARK: - [ㅇ] 녹음 초기화 - 오디오 포맷, 음질, 비트율, 채널및 샘플율
    func initRecord() {
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue, // 음질최대
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
        AVSampleRateKey: 44100.0] as [String : Any] // 샘플률
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true  // 박자관련
        audioRecorder.prepareToRecord()
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value // 볼륨설정
        lblEndTime.text = convertNSTimeInterval2String(0) // 총 재생시간
        lblCurrentTime.text = convertNSTimeInterval2String(0) // 현재 재생시간
        setPlayButtons(false, pause: false, stop: false) // 재생, 일시정지, 정지버튼 비활성화
        
        // 액티브 설정
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
    // MARK: - [ㅇ] 음악재생 초기화
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d : %02d", min, sec)
        return strTime
    }
    
    // MARK: - [ㅇ] 재생, 재생시간 업데이트, 일시정지, 정지
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()
    }
    
    // MARK: - [ㅇ] 볼륨
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    // MARK: - [ㅇ] 재생종료
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    // MARK: - [ㅇ] 녹음 스위치 토글
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn { // 녹음모드로
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else { // 재생모드로
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        
        selectAudioFile() // 확장자 선택
        if !isRecordMode { // 초기화
            initPlay()
        } else {
            initRecord()
        }
    }
    @IBAction func btnRecord(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
            audioRecorder.record()
            sender.setTitle("Stop", for: UIControl.State())
            
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {
            audioRecorder.stop()
            progressTimer.invalidate()
            btnPlay.isEnabled = true
            sender.setTitle("Record", for: UIControl.State())
            initPlay()
        }
    }
    
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}

