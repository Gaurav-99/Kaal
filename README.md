# Kaal ⏳

> *Kaal (Sanskrit/Hindi): Time, Fate, Cosmic cycle, Mortality.*

Kaal is a modern, premium life-awareness and intentional living platform designed to help users visualize time, understand life through meaningful analytics, and become more mindful about how they spend their limited time.

The experience is philosophical, calm, motivating, and deeply meaningful—blending modern wellness apps, stoic philosophy, premium productivity tools, and cinematic futuristic interfaces.

---

## 🌌 The Vision

Kaal aims to help you understand and value your time. Time is our most valuable resource, yet it is the one we often take for granted. Kaal shifts your perspective by providing highly visual, elegant, and emotionally intelligent insights into your life. 

*Note: Kaal is designed to be reflective, peaceful, intentional, and inspiring. It is explicitly designed to avoid feeling depressing, fear-inducing, or death-obsessed.*

## ✨ Core Features

* **Life Expectancy System:** Calculates your estimated remaining lifespan based on personalized health and lifestyle metrics (age, habits, stress, fitness). Visualized via beautiful, animated countdowns.
* **Life in Weeks Visualization:** An impactful, interactive 4,680-square grid where one square equals one week of a 90-year life. Easily see past weeks, remaining weeks, and significant milestones.
* **Custom Countdowns:** Create personalized, beautifully themed countdown timers for meaningful events (birthdays, parents aging, retirement, trips, goals).
* **Intelligent Insight Engine:** Generates thoughtful, philosophical insights (e.g., *"You have approximately 850 weekends left. Make them count."*).
* **Daily Reflection:** Dedicated space for daily mindfulness prompts, stoic quotes, and journaling.
* **Futuristic Dashboard:** A central hub to view your life progress, today's insight, active countdowns, and quick stats.

## 🎨 UI & UX Aesthetic

* **Premium Dark Mode:** Deep blacks, charcoal, deep blue, with muted gold and silver accents.
* **Modern Typography:** Utilizing elegant fonts (Outfit) for a luxurious and emotional feel.
* **Glassmorphism & Minimalism:** Cinematic gradients, soft glow effects, and clutter-free interfaces.
* **Smooth Animations:** Fluid transitions, haptic feedback, and calming micro-interactions.

## 🛠 Tech Stack

* **Frontend:** [Flutter](https://flutter.dev/) (Cross-platform Mobile Development)
* **Backend:** [Supabase](https://supabase.com/) (Authentication, Database, Edge Functions)
* **Database:** PostgreSQL
* **State Management:** Riverpod (`flutter_riverpod`)
* **Routing:** GoRouter
* **Local Storage:** Shared Preferences (for offline support & caching)

## 🚀 Getting Started

### Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* [Dart SDK](https://dart.dev/get-dart)
* Supabase Account (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Gaurav-99/Kaal.git
   cd Kaal
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Environment Setup**
   * Create a Supabase project.
   * Add your Supabase URL and Anon Key to `lib/main.dart` or a `.env` file (if configured).

4. **Run the App**
   ```bash
   flutter run
   ```

## 📂 Project Architecture

We follow a feature-first, highly scalable folder structure:

```text
lib/
├── core/            # App-wide configurations (constants, theme, routing, services, utils)
├── features/        # Feature modules (auth, dashboard, life_calendar, onboarding, etc.)
├── models/          # Data models
├── shared/          # Reusable UI widgets
└── main.dart        # Entry point
```

## 🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Gaurav-99/Kaal/issues).

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.