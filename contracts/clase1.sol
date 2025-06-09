// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
contract Registro {
    string private storedInfo;
    
    function setInfo(string memory myInfo) external {
        storedInfo = myInfo;
    }
    function getInfo() external view returns (string memory) {
        return storedInfo;
    }
}