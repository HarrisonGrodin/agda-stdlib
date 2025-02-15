------------------------------------------------------------------------
-- The Agda standard library
--
-- Base definitions for the left-biased universe-sensitive functor and
-- monad instances for the Product type.
--
-- To minimize the universe level of the RawFunctor, we require that
-- elements of B are "lifted" to a copy of B at a higher universe level
-- (a ⊔ b). See the Data.Product.Effectful.Examples for how this is
-- done.
------------------------------------------------------------------------

{-# OPTIONS --cubical-compatible --safe #-}

open import Level

module Data.Product.Effectful.Left.Base
  {a} (A : Set a) (b : Level) where

open import Data.Product using (_×_; map₂; proj₁; proj₂; <_,_>)
open import Effect.Functor using (RawFunctor)
open import Effect.Comonad using (RawComonad)

------------------------------------------------------------------------
-- Definitions

Productₗ : Set (a ⊔ b) → Set (a ⊔ b)
Productₗ B = A × B

functor : RawFunctor Productₗ
functor = record { _<$>_ = λ f → map₂ f }

comonad : RawComonad Productₗ
comonad = record
  { extract = proj₂
  ; extend  = < proj₁ ,_>
  }
