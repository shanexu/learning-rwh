data BookInfo =
  Book Int String [String]
  deriving (Show)

data MagazineInfo =
  Magazine Int String [String]
  deriving (Show)
  
type CustomerID = Int

type ReviewBody = String

data BetterReview = BetterReview BookInfo CustomerID ReviewBody

type BookRecord = (BookInfo, BookReview)

data BookReview = BookReview BookInfo CustomerID String
