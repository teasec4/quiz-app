# Database Schema

## FolderEntity

- id
- name
- createdAt

## DeckEntity

- id
- title
- createdAt
- folderId

## FlashCardEntity

- id
- front
- back
- createdAt
- deckId
- isLearned

## StudySessionEntity

- id
- endedAt
- totalCards
- correctAnswers
- isCompleted

## StudyAnswerEntity

- id
- cardId
- isCorrect

## UserStatsEntity

- id
- totalCards
- correctAnswers
- lastSessionDate