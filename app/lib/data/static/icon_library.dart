/// Icon definition with categories and premium status
class IconDefinition {
  final String emoji;
  final List<String> categories; // Can belong to multiple categories
  final bool isPremium;
  final List<String> tags; // For search functionality

  const IconDefinition({
    required this.emoji,
    required this.categories,
    this.isPremium = false,
    this.tags = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconDefinition &&
          runtimeType == other.runtimeType &&
          emoji == other.emoji;

  @override
  int get hashCode => emoji.hashCode;
}

/// Complete icon library for the application
class IconLibrary {
  // ========== HEALTH ICONS ==========
  static const List<IconDefinition> health = [
    // Basic health & hygiene
    IconDefinition(emoji: '🪥', categories: ['health'], tags: ['brush', 'teeth', 'dental', 'hygiene']),
    IconDefinition(emoji: '🧼', categories: ['health', 'home'], tags: ['wash', 'hands', 'soap', 'hygiene']),
    IconDefinition(emoji: '🚿', categories: ['health', 'home'], tags: ['shower', 'bath', 'clean', 'hygiene']),
    IconDefinition(emoji: '🛁', categories: ['health', 'home'], tags: ['bath', 'bathtub', 'hygiene']),
    IconDefinition(emoji: '🦷', categories: ['health'], tags: ['tooth', 'dental']),

    // Clothing
    IconDefinition(emoji: '👕', categories: ['health', 'home'], tags: ['dress', 'clothes', 'shirt']),
    IconDefinition(emoji: '👟', categories: ['health', 'home'], tags: ['shoes', 'footwear']),

    // Food & nutrition
    IconDefinition(emoji: '🥦', categories: ['health'], tags: ['vegetables', 'broccoli', 'food', 'healthy']),
    IconDefinition(emoji: '🥗', categories: ['health'], tags: ['salad', 'healthy', 'food', 'vegetables']),
    IconDefinition(emoji: '💧', categories: ['health'], tags: ['water', 'drink', 'hydration']),
    IconDefinition(emoji: '🥕', categories: ['health', 'home'], tags: ['carrot', 'vegetables', 'food']),
    IconDefinition(emoji: '🥒', categories: ['health', 'home'], tags: ['cucumber', 'vegetables', 'food']),
    IconDefinition(emoji: '🌽', categories: ['health', 'home'], tags: ['corn', 'vegetables', 'food']),
    IconDefinition(emoji: '🥔', categories: ['health', 'home'], tags: ['potato', 'vegetables', 'food']),
    IconDefinition(emoji: '🍅', categories: ['health', 'home'], tags: ['tomato', 'vegetables', 'food']),
    IconDefinition(emoji: '🥑', categories: ['health', 'home'], tags: ['avocado', 'fruit', 'food', 'healthy']),
    IconDefinition(emoji: '🍇', categories: ['health'], tags: ['grapes', 'fruit', 'food']),

    // Sports & activities
    IconDefinition(emoji: '⚽', categories: ['health'], tags: ['soccer', 'football', 'sport', 'play', 'outside']),
    IconDefinition(emoji: '🏃', categories: ['health'], tags: ['run', 'running', 'exercise', 'sport']),
    IconDefinition(emoji: '🏀', categories: ['health'], tags: ['basketball', 'sport', 'play']),
    IconDefinition(emoji: '⚾', categories: ['health'], tags: ['baseball', 'sport', 'play']),
    IconDefinition(emoji: '🎾', categories: ['health'], tags: ['tennis', 'sport', 'play']),
    IconDefinition(emoji: '🏐', categories: ['health'], tags: ['volleyball', 'sport', 'play']),
    IconDefinition(emoji: '🏈', categories: ['health'], tags: ['football', 'american', 'sport', 'play']),
    IconDefinition(emoji: '🏉', categories: ['health'], tags: ['rugby', 'sport', 'play']),
    IconDefinition(emoji: '🎱', categories: ['health'], tags: ['billiards', 'pool', 'sport', 'play']),
    IconDefinition(emoji: '🏓', categories: ['health'], tags: ['ping-pong', 'table-tennis', 'sport', 'play']),
    IconDefinition(emoji: '💪', categories: ['health'], tags: ['strong', 'muscle', 'exercise', 'strength']),
    IconDefinition(emoji: '🧘', categories: ['health'], isPremium: true, tags: ['yoga', 'meditation', 'relax']),
    IconDefinition(emoji: '🚴', categories: ['health'], isPremium: true, tags: ['bike', 'cycling', 'exercise']),
    IconDefinition(emoji: '🏊', categories: ['health'], isPremium: true, tags: ['swim', 'swimming', 'pool', 'exercise']),
    IconDefinition(emoji: '🤸', categories: ['health'], isPremium: true, tags: ['gymnastics', 'exercise']),
    IconDefinition(emoji: '🧗', categories: ['health'], isPremium: true, tags: ['climbing', 'sport']),
    IconDefinition(emoji: '⛹️', categories: ['health'], isPremium: true, tags: ['basketball', 'sport']),
    IconDefinition(emoji: '🤾', categories: ['health'], isPremium: true, tags: ['handball', 'sport']),
    IconDefinition(emoji: '🏋️', categories: ['health'], isPremium: true, tags: ['weightlifting', 'gym', 'exercise']),
    IconDefinition(emoji: '🤼', categories: ['health'], isPremium: true, tags: ['wrestling', 'sport']),

    // Sleep & screen time
    IconDefinition(emoji: '😴', categories: ['health'], tags: ['sleep', 'rest', 'bedtime', 'tired']),
    IconDefinition(emoji: '📱', categories: ['health', 'future'], tags: ['phone', 'screen', 'limit', 'device']),

    // Medical
    IconDefinition(emoji: '💊', categories: ['health'], isPremium: true, tags: ['medicine', 'pill', 'medication']),
    IconDefinition(emoji: '🩺', categories: ['health'], isPremium: true, tags: ['doctor', 'stethoscope', 'medical']),
    IconDefinition(emoji: '🧴', categories: ['health', 'home'], tags: ['lotion', 'bottle', 'hygiene']),
    IconDefinition(emoji: '🧻', categories: ['health', 'home'], tags: ['toilet-paper', 'bathroom', 'hygiene']),
  ];

  // ========== HOME ICONS ==========
  static const List<IconDefinition> home = [
    // Cleaning & tidying
    IconDefinition(emoji: '🧹', categories: ['home'], tags: ['broom', 'sweep', 'clean', 'tidy']),
    IconDefinition(emoji: '🧺', categories: ['home'], tags: ['basket', 'laundry', 'clean']),
    IconDefinition(emoji: '🧽', categories: ['home'], tags: ['sponge', 'clean', 'dishes']),
    IconDefinition(emoji: '🗑️', categories: ['home'], tags: ['trash', 'garbage', 'waste', 'bin']),
    IconDefinition(emoji: '🧴', categories: ['health', 'home'], tags: ['bottle', 'cleaning', 'product']),
    IconDefinition(emoji: '🪣', categories: ['home'], isPremium: true, tags: ['bucket', 'cleaning', 'water']),
    IconDefinition(emoji: '🧯', categories: ['home'], isPremium: true, tags: ['fire-extinguisher', 'safety']),

    // Furniture & rooms
    IconDefinition(emoji: '🛏️', categories: ['home', 'health'], tags: ['bed', 'sleep', 'bedroom', 'make-bed']),
    IconDefinition(emoji: '🪑', categories: ['home'], tags: ['chair', 'furniture', 'sit']),
    IconDefinition(emoji: '🏠', categories: ['home'], tags: ['house', 'home', 'building']),
    IconDefinition(emoji: '🏡', categories: ['home'], isPremium: true, tags: ['house', 'home', 'garden']),
    IconDefinition(emoji: '🏘️', categories: ['home'], isPremium: true, tags: ['houses', 'neighborhood']),
    IconDefinition(emoji: '🏚️', categories: ['home'], isPremium: true, tags: ['old-house', 'abandoned']),
    IconDefinition(emoji: '🏗️', categories: ['home'], isPremium: true, tags: ['construction', 'building']),
    IconDefinition(emoji: '🏭', categories: ['home'], isPremium: true, tags: ['factory', 'building']),
    IconDefinition(emoji: '🏢', categories: ['home'], isPremium: true, tags: ['office', 'building']),
    IconDefinition(emoji: '🏬', categories: ['home'], isPremium: true, tags: ['store', 'shopping']),
    IconDefinition(emoji: '🏣', categories: ['home'], isPremium: true, tags: ['post-office', 'mail']),

    // Kitchen & cooking
    IconDefinition(emoji: '🍽️', categories: ['home'], tags: ['dishes', 'plate', 'table', 'set-table']),
    IconDefinition(emoji: '👨‍🍳', categories: ['home'], tags: ['cook', 'chef', 'cooking', 'kitchen']),
    IconDefinition(emoji: '🥘', categories: ['home'], tags: ['cooking', 'pot', 'meal', 'food']),
    IconDefinition(emoji: '🛒', categories: ['home'], tags: ['shopping', 'cart', 'grocery', 'store']),
    IconDefinition(emoji: '📋', categories: ['home', 'future'], tags: ['clipboard', 'list', 'plan', 'checklist']),

    // Organization & storage
    IconDefinition(emoji: '🎒', categories: ['home', 'future'], tags: ['backpack', 'school', 'pack', 'bag']),
    IconDefinition(emoji: '👔', categories: ['home'], tags: ['tie', 'clothes', 'fold', 'laundry']),
    IconDefinition(emoji: '🗂️', categories: ['home', 'future'], tags: ['organize', 'files', 'folders', 'desk']),
    IconDefinition(emoji: '📦', categories: ['home'], tags: ['box', 'storage', 'organize', 'package']),

    // Pets & plants
    IconDefinition(emoji: '🐕', categories: ['home'], tags: ['dog', 'pet', 'feed', 'walk']),
    IconDefinition(emoji: '🌱', categories: ['home'], tags: ['plant', 'water', 'grow', 'garden']),
    IconDefinition(emoji: '🌳', categories: ['home'], tags: ['tree', 'garden', 'yard', 'nature']),

    // Toys & kids stuff
    IconDefinition(emoji: '🧸', categories: ['home'], tags: ['teddy-bear', 'toy', 'tidy', 'kids']),

    // Family & relationships
    IconDefinition(emoji: '👥', categories: ['home', 'future'], tags: ['people', 'family', 'help', 'sibling', 'together']),
    IconDefinition(emoji: '🤝', categories: ['home', 'future'], tags: ['handshake', 'help', 'cooperation', 'volunteer']),

    // Tools & maintenance
    IconDefinition(emoji: '🔧', categories: ['home'], isPremium: true, tags: ['wrench', 'tool', 'fix', 'repair']),
    IconDefinition(emoji: '🔨', categories: ['home'], isPremium: true, tags: ['hammer', 'tool', 'fix', 'build']),
    IconDefinition(emoji: '🪛', categories: ['home'], isPremium: true, tags: ['screwdriver', 'tool', 'fix']),
    IconDefinition(emoji: '🪚', categories: ['home'], isPremium: true, tags: ['saw', 'tool', 'wood', 'cut']),

    // Transportation
    IconDefinition(emoji: '🚗', categories: ['home'], tags: ['car', 'vehicle', 'wash', 'transport']),
  ];

  // ========== FUTURE (Education & Skills) ICONS ==========
  static const List<IconDefinition> future = [
    // Books & reading
    IconDefinition(emoji: '📚', categories: ['future'], tags: ['books', 'reading', 'study', 'library', 'education']),
    IconDefinition(emoji: '📖', categories: ['future'], tags: ['book', 'read', 'open-book', 'study']),
    IconDefinition(emoji: '📕', categories: ['future'], tags: ['book', 'red', 'study', 'reading']),
    IconDefinition(emoji: '📗', categories: ['future'], tags: ['book', 'green', 'study', 'reading']),
    IconDefinition(emoji: '📘', categories: ['future'], tags: ['book', 'blue', 'study', 'reading']),
    IconDefinition(emoji: '📙', categories: ['future'], tags: ['book', 'orange', 'study', 'reading']),

    // Writing & notes
    IconDefinition(emoji: '📝', categories: ['future'], tags: ['write', 'note', 'homework', 'journal', 'paper']),
    IconDefinition(emoji: '✏️', categories: ['future'], tags: ['pencil', 'write', 'draw', 'homework']),
    IconDefinition(emoji: '📔', categories: ['future'], tags: ['notebook', 'write', 'journal', 'notes']),
    IconDefinition(emoji: '📓', categories: ['future'], tags: ['notebook', 'write', 'notes', 'study']),

    // Arts & creativity
    IconDefinition(emoji: '🎨', categories: ['future'], tags: ['art', 'paint', 'creative', 'draw', 'palette']),
    IconDefinition(emoji: '🎭', categories: ['future'], tags: ['theater', 'drama', 'performance', 'arts']),
    IconDefinition(emoji: '🎪', categories: ['future'], tags: ['circus', 'tent', 'performance', 'fun']),
    IconDefinition(emoji: '🎬', categories: ['future'], tags: ['movie', 'film', 'cinema', 'video']),

    // Music
    IconDefinition(emoji: '🎵', categories: ['future'], tags: ['music', 'note', 'song', 'melody']),
    IconDefinition(emoji: '🎸', categories: ['future'], tags: ['guitar', 'music', 'instrument', 'practice']),
    IconDefinition(emoji: '🎹', categories: ['future'], tags: ['piano', 'keyboard', 'music', 'instrument']),
    IconDefinition(emoji: '🎺', categories: ['future'], tags: ['trumpet', 'music', 'instrument', 'brass']),
    IconDefinition(emoji: '🎻', categories: ['future'], tags: ['violin', 'music', 'instrument', 'strings']),
    IconDefinition(emoji: '🥁', categories: ['future'], tags: ['drum', 'music', 'instrument', 'percussion']),
    IconDefinition(emoji: '🎤', categories: ['future'], tags: ['microphone', 'music', 'singing', 'performance']),
    IconDefinition(emoji: '🎧', categories: ['future'], tags: ['headphones', 'music', 'listen', 'audio']),

    // Gaming & entertainment
    IconDefinition(emoji: '🎮', categories: ['future'], tags: ['game', 'controller', 'video-game', 'play']),
    IconDefinition(emoji: '🎲', categories: ['future'], tags: ['dice', 'game', 'play', 'board-game']),

    // Goals & achievement
    IconDefinition(emoji: '🎯', categories: ['future'], tags: ['target', 'goal', 'aim', 'achievement', 'focus']),
    IconDefinition(emoji: '💡', categories: ['future'], tags: ['idea', 'lightbulb', 'learn', 'bright', 'creative']),
    IconDefinition(emoji: '✨', categories: ['future'], tags: ['sparkle', 'magic', 'special', 'shine', 'star']),
    IconDefinition(emoji: '⭐', categories: ['future'], tags: ['star', 'favorite', 'achievement', 'success']),
    IconDefinition(emoji: '🌟', categories: ['future'], tags: ['glowing-star', 'achievement', 'success', 'shine']),
    IconDefinition(emoji: '🔥', categories: ['future'], tags: ['fire', 'hot', 'energy', 'motivation']),

    // Technology & digital
    IconDefinition(emoji: '💻', categories: ['future'], tags: ['computer', 'laptop', 'technology', 'coding', 'online']),
    IconDefinition(emoji: '📱', categories: ['health', 'future'], tags: ['phone', 'mobile', 'device', 'technology']),
    IconDefinition(emoji: '🖥️', categories: ['future'], isPremium: true, tags: ['desktop', 'computer', 'monitor']),

    // Planning & organization
    IconDefinition(emoji: '📅', categories: ['future'], tags: ['calendar', 'schedule', 'plan', 'date', 'organize']),
    IconDefinition(emoji: '📋', categories: ['home', 'future'], tags: ['clipboard', 'list', 'checklist', 'plan']),
    IconDefinition(emoji: '🗂️', categories: ['home', 'future'], tags: ['files', 'organize', 'folders', 'digital']),

    // Money & finance
    IconDefinition(emoji: '💰', categories: ['future'], tags: ['money', 'finance', 'budget', 'savings', 'wealth']),
    IconDefinition(emoji: '💵', categories: ['future'], isPremium: true, tags: ['dollar', 'money', 'cash', 'finance']),
    IconDefinition(emoji: '💳', categories: ['future'], isPremium: true, tags: ['credit-card', 'payment', 'finance']),

    // Social & community
    IconDefinition(emoji: '🤝', categories: ['home', 'future'], tags: ['help', 'volunteer', 'community', 'cooperation']),
    IconDefinition(emoji: '👥', categories: ['home', 'future'], tags: ['people', 'group', 'team', 'social']),

    // Space & exploration
    IconDefinition(emoji: '🚀', categories: ['future'], isPremium: true, tags: ['rocket', 'space', 'launch', 'exploration']),
    IconDefinition(emoji: '🛸', categories: ['future'], isPremium: true, tags: ['ufo', 'space', 'alien', 'flying']),
    IconDefinition(emoji: '🌍', categories: ['future'], isPremium: true, tags: ['earth', 'world', 'globe', 'planet']),
    IconDefinition(emoji: '🌎', categories: ['future'], isPremium: true, tags: ['earth', 'americas', 'world', 'globe']),
    IconDefinition(emoji: '🌏', categories: ['future'], isPremium: true, tags: ['earth', 'asia', 'world', 'globe']),
    IconDefinition(emoji: '🗺️', categories: ['future'], isPremium: true, tags: ['map', 'world', 'geography', 'travel']),
    IconDefinition(emoji: '🧭', categories: ['future'], isPremium: true, tags: ['compass', 'navigation', 'direction']),
  ];

  // ========== ALL ICONS ==========
  /// Complete list of all icons across all categories
  static const List<IconDefinition> all = [
    ...health,
    ...home,
    ...future,
  ];

  // ========== UTILITY METHODS ==========

  /// Get all icons for a specific category
  static List<IconDefinition> byCategory(String categoryId) {
    return all.where((icon) => icon.categories.contains(categoryId)).toList();
  }

  /// Get all icons for multiple categories
  static List<IconDefinition> byCategories(List<String> categoryIds) {
    return all.where((icon) =>
      icon.categories.any((cat) => categoryIds.contains(cat))
    ).toList();
  }

  /// Get only free (non-premium) icons
  static List<IconDefinition> get free {
    return all.where((icon) => !icon.isPremium).toList();
  }

  /// Get only premium icons
  static List<IconDefinition> get premium {
    return all.where((icon) => icon.isPremium).toList();
  }

  /// Get free icons for a specific category
  static List<IconDefinition> freeByCategory(String categoryId) {
    return all.where((icon) =>
      icon.categories.contains(categoryId) && !icon.isPremium
    ).toList();
  }

  /// Search icons by query (searches in tags and emoji)
  static List<IconDefinition> search(String query) {
    final lowerQuery = query.toLowerCase();
    return all.where((icon) =>
      icon.emoji.contains(query) ||
      icon.tags.any((tag) => tag.toLowerCase().contains(lowerQuery))
    ).toList();
  }

  /// Get a random icon from a category
  static IconDefinition? randomFromCategory(String categoryId) {
    final icons = byCategory(categoryId);
    if (icons.isEmpty) return null;
    return icons[DateTime.now().millisecondsSinceEpoch % icons.length];
  }

  /// Check if an emoji is in the library
  static bool contains(String emoji) {
    return all.any((icon) => icon.emoji == emoji);
  }

  /// Get IconDefinition by emoji
  static IconDefinition? getByEmoji(String emoji) {
    try {
      return all.firstWhere((icon) => icon.emoji == emoji);
    } catch (e) {
      return null;
    }
  }

  /// Get all unique emojis as a simple list
  static List<String> get allEmojis {
    return all.map((icon) => icon.emoji).toList();
  }

  /// Get all emojis for a category
  static List<String> emojisForCategory(String categoryId) {
    return byCategory(categoryId).map((icon) => icon.emoji).toList();
  }
}
