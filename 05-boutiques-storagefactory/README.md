# Boutiques — Storage Factory Capstone

A small system where a factory contract creates one shop contract per merchant, each shop having its own owner, products and sales history. Built from a requirements spec, without a solution, to consolidate the Storage Factory section of the Solidity Smart Contract Development course (Cyfrin Updraft).

## Contracts

- `Proprietaire` — Stores the owner's address and provides an internal check that child contracts call at the start of restricted functions.
- `Boutique` — A shop that inherits from `Proprietaire`. It receives its owner and name at creation, holds products (name, price, quantity), records total sold per product, and computes the value of its stock.
- `FabriqueBoutiques` — A factory that anyone can call to create a shop owned by the caller. It tracks all shops, returns the owner of a given shop, and sums the stock value of every shop.

## Concepts used

`import`, inheritance with `is`, `internal` functions, `new`, constructor parameters, `struct`, dynamic arrays, `mapping`, `storage` references, loops, `require`.

## Notes

The owner is passed to the `Boutique` constructor instead of read from `msg.sender`: when a contract creates another with `new`, `msg.sender` inside the new contract's constructor is the factory, not the user.