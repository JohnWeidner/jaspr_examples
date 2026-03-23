/// Persistent server-side state that lives for the lifetime of the process.
///
/// This state is shared across all requests. It resets when the server
/// restarts — a real app would use a database.
library;

/// A high score entry for the snake game.
class HighScore {
  /// Creates a [HighScore].
  HighScore({required this.name, required this.score, required this.time});

  /// The player's name.
  final String name;

  /// Their highest score (mutable — updated when beaten).
  int score;

  /// When the entry was first created.
  final DateTime time;

  /// Serializes to JSON for the API response.
  Map<String, dynamic> toJson() => {'name': name, 'score': score};
}

/// The top 10 snake high scores, sorted descending by score.
final List<HighScore> highScores = [];
