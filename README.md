# SwiftUI_05_Mar

A basic SwiftUI app, starting from the fundamentals and building up.

here are some images of my features:
<img width="264" alt="Screenshot 2025-03-05 at 3 01 59ΓÇ»PM" src="https://github.com/user-attachments/assets/cec43906-d266-49cd-bcf9-e87f7eae6bc5" />
<img width="264" alt="Screenshot 2025-03-05 at 3 01 34ΓÇ»PM" src="https://github.com/user-attachments/assets/e90e251d-5e10-4d14-967d-8ac49e8aad18" />
<img width="1470" alt="Screenshot 2025-03-05 at 3 04 11ΓÇ»PM" src="https://github.com/user-attachments/assets/8bca7e43-c2dc-4dda-9483-8b2ec319bb16" />
<img width="947" alt="Screenshot 2025-03-05 at 3 03 11ΓÇ»PM" src="https://github.com/user-attachments/assets/1be630c7-aa6f-44b2-8d1d-79366dbb2fc4" />
<img width="264" alt="Screenshot 2025-03-05 at 3 02 09ΓÇ»PM" src="https://github.com/user-attachments/assets/815c9b60-eccf-4c99-bd1a-d5d7bc58fe19" />

video demo:
![image](https://github.com/user-attachments/assets/fa242256-0bbf-4df6-9ea2-f6dacae76b70)

swift using MacBook Air with running on xcode and i use playgrund to test out things

features include 
-login
-dark/light mode
  - `    Button(action: {
                        if isValid && !username.isEmpty {
                            isLoggedIn = true
                        }
                    }) {
                        Text(
                            "Login"
                        )
                        .fontWeight(
                            .bold
                        )
                        .font(
                            .title2
                        )
                        .padding()
                        .frame(
                            maxWidth: .infinity
                        )
                        .background(
                            isValid && !username.isEmpty ? Color.green : Color.color1
                        )
                        .foregroundColor(
                            darkModeOn ? .black: .white
                        )
                        .cornerRadius(
                            8
                        )
                    }
                    
                    .disabled(
                        !(
                            isValid && !username.isEmpty
                        )
                    )
    `
-profile page
-counter
-playlist (song can be played i attatch mp3 file into the code for it to run when the play button is clicked) - [improvement to be made i can put the song for different titles into a dictionary so when i click on specific song it will play the specific song related to the title but in this case it was a 3 days workshop and i only put in one song for all song titles dur to time constraint]
  - `struct PlayListScreen: View {
    @State private var isPlaying = false
    @State private var volume: Double = 0
    @State private var timer: Cancellable? = nil
    @State private var audioPlayer: AVAudioPlayer? = nil  // Audio player instance
    
    let itemName: String
    
    let songLyrics: [String: [String]] = [
        "Chasing the Horizon": [
            "Woke up to the sunrise, the world in my hands,",
            "Chasing the horizon, no map, no plans.",
            "Every step a story, every mile a dream,",
            "Fighting through the shadows, to the place I want to be."
        ],
        "Waves of Yesterday": [
            "The waves of yesterday crash on the shore,",
            "I’m holding on, but I can’t take it anymore.",
            "The past keeps haunting, it pulls me back in,",
            "But I’m trying to move forward, to find where I’ve been."
        ]
    ]
    
    var body: some View {
        
        VStack {
            Text(
                "\(itemName)"
            )
            .font(
                .largeTitle
            )
            .fontWeight(
                .bold
            )
            .padding(
                .top
            )
            Image(
                "gratisography-happy-cone"
            )
            .resizable()
            .scaledToFit()
            .frame(
                maxWidth: 400,
                maxHeight: 250
            )
            .padding(
                .bottom
            )
            
            if let lyrics = songLyrics[itemName] {
                VStack(
                    alignment: .leading
                ) {
                    ForEach(
                        lyrics,
                        id: \.self
                    ) { line in
                        Text(
                            line
                        )
                        .font(
                            .body
                        )
                        .padding(
                            1
                        )
                    }
                }
                .padding(
                    .bottom
                )
                .padding()
            }
            
            Section {
                Slider(
                    value: $volume,
                    in: 0...60
                )
                
                // Convert volume (which ranges from 0 to 60) into a time format
                let totalSeconds = Int(
                    volume
                )
                let minutes = totalSeconds / 60
                let seconds = totalSeconds % 60
                
                // Format the time as mm:ss
                Text(
                    String(
                        format: "%02d:%02d",
                        minutes,
                        seconds
                    )
                )
                .font(
                    .caption
                )
                .italic()
            }
            
            HStack {
                Button(action: {
                    isPlaying.toggle()
                    
                    if isPlaying {
                        startTimer()  // Start the timer when playing
                        startAudio()  // Start the audio when playing
                    } else {
                        stopTimer()  // Stop the timer when paused
                        stopAudio()  // Stop the audio when paused
                    }
                }) {
                    Image(
                        systemName: isPlaying ? "pause.fill" : "play.fill"
                    )
                    .font(
                        .system(
                            size: 50
                        )
                    )
                    .foregroundColor(
                        isPlaying ? .red : .green
                    )
                    .padding()
                    .background(
                        Circle().fill(
                            Color.white
                        )
                    )
                    .shadow(
                        radius: 10
                    )
                }
                .padding(
                    .bottom
                )
            }
            
            
        }
        .padding()
        .navigationTitle(
            "Song title: \(itemName)"
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
    
    // Function to start the timer
    func startTimer() {
        timer = Timer.publish(
            every: 0.1,
            on: .main,
            in: .common
        )
        .autoconnect()
        .sink { _ in
            if volume < 60 {
                volume += 0.1  // Increase volume over time
            } else {
                stopTimer()  // Stop when volume reaches 60 (representing full playback)
            }
        }
    }
    
    // Function to stop the timer
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    // Function to start the audio playback
    func startAudio() {
        // Get the file path for the song from the app's bundle
        guard let soundURL = Bundle.main.url(
            forResource: "gardens-stylish-chill-303261",
            withExtension: "mp3"
        ) else {
            print(
                "Sound file not found"
            )
            return
        }
        
        // Debugging: print the sound file path
        print(
            "Sound file path: \(soundURL.path)"
        )  // This will print the path of the file in the app bundle
        
        do {
            // Create the audio player
            audioPlayer = try AVAudioPlayer(
                contentsOf: soundURL
            )
            audioPlayer?.play()
            audioPlayer?.volume = Float(
                volume / 70.0
            )  // Set the volume based on the slider value
        } catch {
            print(
                "Error loading audio: \(error.localizedDescription)"
            )
        }
    }
    
    // Function to stop the audio playback
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

struct PlayListScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayListScreen(
            itemName: "Chasing the Horizon"
        )
    }
}
`
