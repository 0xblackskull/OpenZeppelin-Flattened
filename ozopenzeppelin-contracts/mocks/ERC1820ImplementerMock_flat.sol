// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// OpenZeppelin Contracts v4.4.1 (utils/introspection/ERC1820Implementer.sol)

// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC1820Implementer.sol)

/**
 * @dev Interface for an ERC1820 implementer, as defined in the
 * https://eips.ethereum.org/EIPS/eip-1820#interface-implementation-erc1820implementerinterface[EIP].
 * Used by contracts that will be registered as implementers in the
 * {IERC1820Registry}.
 */
interface IERC1820Implementer {
    /**
     * @dev Returns a special value (`ERC1820_ACCEPT_MAGIC`) if this contract
     * implements `interfaceHash` for `account`.
     *
     * See {IERC1820Registry-setInterfaceImplementer}.
     */
    function canImplementInterfaceForAddress(bytes32 interfaceHash, address account) external view returns (bytes32);
}

/**
 * @dev Implementation of the {IERC1820Implementer} interface.
 *
 * Contracts may inherit from this and call {_registerInterfaceForAddress} to
 * declare their willingness to be implementers.
 * {IERC1820Registry-setInterfaceImplementer} should then be called for the
 * registration to be complete.
 */
contract ERC1820Implementer is IERC1820Implementer {
    bytes32 private constant _ERC1820_ACCEPT_MAGIC = keccak256("ERC1820_ACCEPT_MAGIC");

    mapping(bytes32 => mapping(address => bool)) private _supportedInterfaces;

    /**
     * @dev See {IERC1820Implementer-canImplementInterfaceForAddress}.
     */
    function canImplementInterfaceForAddress(bytes32 interfaceHash, address account)
        public
        view
        virtual
        override
        returns (bytes32)
    {
        return _supportedInterfaces[interfaceHash][account] ? _ERC1820_ACCEPT_MAGIC : bytes32(0x00);
    }

    /**
     * @dev Declares the contract as willing to be an implementer of
     * `interfaceHash` for `account`.
     *
     * See {IERC1820Registry-setInterfaceImplementer} and
     * {IERC1820Registry-interfaceHash}.
     */
    function _registerInterfaceForAddress(bytes32 interfaceHash, address account) internal virtual {
        _supportedInterfaces[interfaceHash][account] = true;
    }
}

contract ERC1820ImplementerMock is ERC1820Implementer {
    function registerInterfaceForAddress(bytes32 interfaceHash, address account) public {
        _registerInterfaceForAddress(interfaceHash, account);
    }
}

