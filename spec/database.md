# Database Schema

Models location: `lib/data/models/`

## FolderEntity

- id
- name
- createdAt

Location: `lib/data/models/library/folder_entity.dart`

## DeckEntity

- id
- title
- createdAt
- folderId

Location: `lib/data/models/library/deck_entity.dart`

## FlashCardEntity

- id
- front
- back
- createdAt
- deckId
- isLearned

Location: `lib/data/models/library/flashcard_entity.dart`

## StudySessionEntity

- id
- endedAt
- totalCards
- correctAnswers
- isCompleted

Location: `lib/data/models/session/study_session_entity.dart`

## StudyAnswerEntity

- id
- cardId
- isCorrect

Location: `lib/data/models/session/study_answer_entity.dart`

## UserStatsEntity

- id
- totalCards
- correctAnswers
- lastSessionDate

Location: `lib/data/models/user_stats/user_stats_entity.dart`