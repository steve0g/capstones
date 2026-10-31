// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Proprietaire {

    // l’adresse du propriétaire est lisible par tout le monde.
    address public proprietaire;

    // Il fournit une vérification que les contrats enfants appellent en début de fonction
    // Si l’appelant n’est pas le propriétaire, la transaction est annulée avec un message.
    function verification() internal view {
        require(msg.sender == proprietaire, "You are not the owner");
    }
}