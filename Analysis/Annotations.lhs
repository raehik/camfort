> {-# LANGUAGE DeriveDataTypeable #-}
> {-# LANGUAGE MultiParamTypeClasses #-}
> {-# LANGUAGE TypeSynonymInstances #-}
> {-# LANGUAGE FlexibleInstances #-}

> module Analysis.Annotations where

> import Data.Data
> import Data.Generics.Uniplate.Operations

> import Data.Map.Lazy hiding (map)

> import Debug.Trace

> import Language.Haskell.ParseMonad 
> import Language.Haskell.Syntax (SrcLoc(..))

> import Language.Fortran
> import Analysis.IntermediateReps 

> type Report = String

Additional "helper" syntax (NOT GENERATED BY PARSER)

Loop classifications 

> data ReduceType = Reduce | NoReduce
> data AccessPatternType = Regular | RegularAndConstants | Irregular | Undecidable 
> data LoopType = Functor ReduceType 
>               | Gather ReduceType ReduceType AccessPatternType 
>               | Scatter ReduceType AccessPatternType

 classify :: Fortran Annotation -> Fortran Annotation
 classify x = 

> type A = Annotation

> data Annotation = A {indices :: [Variable],
>                      lives ::([Access],[Access]),
>                      arrsRead :: Map Variable [[Expr ()]], 
>                      arrsWrite :: Map Variable [[Expr ()]],
>                      unitVar :: Int,
>                      number :: Int,
>                      refactored :: Maybe SrcLoc, 
>                      successorStmts :: [Int]}
>                    deriving (Eq, Show, Typeable, Data)

> liveOut = snd . lives
> liveIn = fst . lives

 -- Map Variable [[(Variable,Int)]],

> pRefactored :: Annotation -> Bool
> pRefactored x = case (refactored x) of
>                   Nothing -> False
>                   Just _  -> True

> unitAnnotation = A [] ([], []) empty empty 0 0 Nothing []

