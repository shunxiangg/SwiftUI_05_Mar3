import SwiftUI
import Combine
import AVFoundation

struct ContentView: View {
    @State private var email: String = ""
    @State private var darkModeOn = false
    @State private var volume: Double = 0.5 // Change to Double for the Slider
    @State private var isLoggedIn = false // State variable to track login
    @State private var username = ""
    @State private var isValid = false
    @State private var selectColor = ""
    let colors = [
        "Male",
        "Female",
        "Others"
    ]
    
    func isEmailValid(
        _ email: String
    ) -> Bool{
        return email.contains(
            "@"
        ) && email.contains(
            "."
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        // Username TextField with custom styling
                        TextField(
                            "Your Username",
                            text: $username
                        )
                        .textInputAutocapitalization(
                            .never
                        )
                        .padding()
                        .background(
                            Color.gray.opacity(
                                0.1
                            )
                        )
                        .cornerRadius(
                            8
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 8
                            )
                            .stroke(
                                username.isEmpty ? Color.color1 : Color.green,
                                lineWidth: 1
                            )
                        )
                        .font(
                            .headline
                        )
                        .padding(
                            .bottom,
                            5
                        )
                        
                        Text(
                            "\(!username.isEmpty ? "valid username" : "invalid username")"
                        )
                        .italic()
                        .font(
                            .caption
                        )
                        .foregroundStyle(
                            !username.isEmpty ? .green : .color1
                        )
                    }
                    
                    Section {
                        // Email TextField with validation
                        TextField(
                            "Your email",
                            text: $email
                        )
                        .textInputAutocapitalization(
                            .never
                        )
                        .onChange(
                            of: email
                        ) {
                            isValid = isEmailValid(
                                email
                            )
                        }
                        .padding()
                        .background(
                            Color.gray.opacity(
                                0.1
                            )
                        )
                        .cornerRadius(
                            8
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 8
                            )
                            .stroke(
                                isValid ? Color.green : Color.color1,
                                lineWidth: 1
                            )
                        )
                        .font(
                            .headline
                        )
                        .padding(
                            .bottom,
                            5
                        )
                        
                        Text(
                            "\(isValid ? "valid email" : "invalid email")"
                        )
                        .italic()
                        .font(
                            .caption
                        )
                        .foregroundStyle(
                            isValid ? .green : .color1
                        )
                    }
                    
                    
                    
                    
                    Section(
                        "Display"
                    ) {
                        Toggle(
                            "Enable dark mode",
                            isOn: $darkModeOn
                        )
                        Text(
                            "Dark mode is \(darkModeOn ? "on" : "off")"
                        )
                        .foregroundStyle(
                            .blue
                        )
                        .font(
                            .caption
                        )
                        .italic()
                    }
                    
                    Section(
                        "Color"
                    ){
                        Picker(
                            "Select your gender",
                            selection:
                                $selectColor
                        ){
                            ForEach(
                                colors,
                                id: \.self
                            ){
                                color in
                                Text(
                                    color
                                )
                            }
                        }
                        
                        //                .pickerStyle(.menu)
                        //                .pickerStyle(.inline)
                        .pickerStyle(
                            .menu
                        )
                        
                        
                    }
                    
                    
                    // Login Button with dynamic styling
                    Button(action: {
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
                    ) // Disable when either condition fails
                    
                }
                
                .preferredColorScheme(
                    darkModeOn ? .dark : .light
                ) // Change color scheme
                .navigationTitle(
                    "Login Screen"
                )
                
                // Trigger navigation when login is successful
                NavigationLink(
                    destination: MainScreen(),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }
                .hidden() // Hide the NavigationLink
            }
        }
    }
}





struct MainScreen: View {
    var body: some View {
        
        VStack {
            
            NavigationLink(
                destination: SecondScreen()
            ) {
                Text(
                    "Profile"
                )
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color.green.opacity(
                                    0.4
                                ),
                                Color.green.opacity(
                                    0.5
                                ),
                                Color.green.opacity(
                                    0.7
                                ),
                                Color.green.opacity(
                                    0.9
                                )
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(
                    .white
                )
                .fontWeight(
                    .bold
                )
                .font(
                    .title2
                )
                .cornerRadius(
                    50
                )
                .frame(
                    width: 200,
                    height: 60
                )
                .shadow(
                    radius: 10
                )
            }
            .padding(
                .bottom,
                20
            )
            
            NavigationLink(
                destination: ThirdScreen()
            ) {
                Text(
                    "Counter"
                )
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color.purple.opacity(
                                    0.7
                                ),
                                Color.purple.opacity(
                                    0.9
                                ),
                                Color.purple.opacity(
                                    0.5
                                ),
                                Color.purple.opacity(
                                    0.4
                                )
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(
                    .white
                )
                .fontWeight(
                    .bold
                )
                .font(
                    .title2
                )
                .cornerRadius(
                    50
                )
                .frame(
                    width: 200,
                    height: 60
                )
                .shadow(
                    radius: 10
                )
            }
            .padding(
                .bottom,
                20
            )
            
            NavigationLink(
                destination: ForthScreen()
            ) {
                Text(
                    "PlayList"
                )
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color.blue.opacity(
                                    0.4
                                ),
                                Color.blue.opacity(
                                    0.7
                                ),
                                Color.blue.opacity(
                                    0.5
                                ),
                                Color.blue.opacity(
                                    0.9
                                )
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(
                    .white
                )
                .fontWeight(
                    .bold
                )
                .font(
                    .title2
                )
                .cornerRadius(
                    50
                )
                .frame(
                    width: 200,
                    height: 60
                )
                .shadow(
                    radius: 10
                )
            }
            .padding(
                .bottom,
                20
            )
        }
        .navigationTitle(
            "Home Screen"
        )
        //        .padding(.top, 30)
    }
}


struct SecondScreen: View {
    func formatName(
        prefix: String,
        firstName: String,
        lastName: String
    ) -> String {
        return "\(prefix). \(firstName.uppercased()) \(lastName.uppercased())"
    }
    
    var body: some View {
        Text(
            "Second Page"
        )
        .font(
            .title
        )
        .foregroundColor(
            .primary
        )
        .padding()
        .navigationTitle(
            "Profile"
        )
        
        VStack {
            Image(
                systemName: "person.circle.fill"
            )
            .resizable()
            .scaledToFit()
            .frame(
                width: 30,
                height: 30
            )
            .foregroundColor(
                Color(
                    hue: 0.63,
                    saturation: 0.999,
                    brightness: 0.716
                )
            )
            Text(
                formatName(
                    prefix: "Mr",
                    firstName: "John",
                    lastName: "doe"
                )
            )
            .font(
                .title
            )
            .fontWeight(
                .bold
            )
            .foregroundColor(
                .primary
            )
            
            Text(
                "Student"
            )
            .font(
                .body
            )
            .foregroundColor(
                .secondary
            )
            .padding(
                .bottom,
                20
            )
            
            HStack(
                spacing: 20
            ) {
                Image(
                    "instagram"
                )
                .resizable()
                .scaledToFit()
                
                Image(
                    "facebook"
                )
                .resizable()
                .scaledToFit()
            }
            .frame(
                width: 100,
                height: 60
            )
        }
    }
}

struct ThirdScreen: View {
    @State private var numOfTimes = 0
    
    func getColor(
        for count: Int
    ) -> Color {
        switch count {
        case 0:
            return .gray
        case 1...5:
            return .green
        case 6...10:
            return .blue
        default:
            return .purple
        }
    }
    
    var body: some View {
        VStack {
            Text(
                "Counter: \(numOfTimes)"
            )
            .font(
                .title2
            )
            .bold()
            .padding(
                [
                    .top,
                    .bottom
                ],
                10
            )
            .padding(
                [
                    .leading,
                    .trailing
                ],
                20
            )
            .background(
                getColor(
                    for: numOfTimes
                )
            )
            .cornerRadius(
                50
            )
            .foregroundColor(
                .white
            )
            .shadow(
                radius: 10
            )
            .padding(
                .bottom,
                30
            )
            
            HStack {
                if numOfTimes > 0 {
                    Button(
                        "Decrease"
                    ) {
                        numOfTimes -= 1
                    }
                    .padding()
                    .background(
                        Color.blue
                    )
                    .foregroundColor(
                        .white
                    )
                    .fontWeight(
                        .bold
                    )
                    .font(
                        .title
                    )
                    .cornerRadius(
                        25
                    )
                } else {
                    Button(
                        "Decrease"
                    ) {
                        numOfTimes -= 1
                    }
                    .padding()
                    .background(
                        Color.blue
                    )
                    .foregroundColor(
                        .white
                    )
                    .fontWeight(
                        .bold
                    )
                    .font(
                        .title
                    )
                    .cornerRadius(
                        25
                    )
                    .disabled(
                        true
                    )
                }
                
                Button(
                    "Increase"
                ) {
                    numOfTimes += 1
                }
                .padding()
                .background(
                    Color.red
                )
                .foregroundColor(
                    .white
                )
                .fontWeight(
                    .bold
                )
                .font(
                    .title
                )
                .cornerRadius(
                    25
                )
                .shadow(
                    radius: 5
                )
            }
            
            Button(
                "Reset"
            ) {
                numOfTimes = 0
            }
            .padding()
            .background(
                Color.gray
            )
            .foregroundColor(
                .white
            )
            .fontWeight(
                .bold
            )
            .font(
                .title
            )
            .cornerRadius(
                25
            )
            .hoverEffect(
                .highlight
            )
            .shadow(
                radius: 5
            )
        }
        .navigationTitle(
            "Counter"
        )
        .padding()
    }
}

struct ForthScreen: View {
    let items: [String] = [
        "Chasing the Horizon",
        "Waves of Yesterday",
        "Dancing Through the Storm",
        "Echoes of the Dreamer",
        "Into the Unknown",
        "Midnight Mirage",
        "Whispers in the Dark",
        "City of Broken Hearts",
        "Unspoken Truths",
        "Rising from the Ashes",
        "Lost in the Lights",
        "When Stars Fall Down",
        "Beneath the Silver Moon",
        "Eternal Summer",
        "Fading Shadows",
        "Tides of Time",
        "Running Wild",
        "On the Edge of Forever",
        "Heartbeat in the Silence",
        "The Road Less Traveled"
    ]
    
    var body: some View {
        List(
            items,
            id: \.self
        ) { item in
            NavigationLink(
                destination: PlayListScreen(
                    itemName: item
                )
            ) {
                Text(
                    "\(item)"
                )
            }
        }
    }
}


struct PlayListScreen: View {
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


//struct PlayListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayListScreen(itemName: "Chasing the Horizon")
//    }
//}


// Preview
#Preview {
    ContentView()
}
