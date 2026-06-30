// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    mapping(string => uint256) public votingToName;
    string[] public names;

    function vote(string memory name, uint256 votes) public {
        require(votes != 0, "votes can not be 0");
        if (votingToName[name] == 0) {
            names.push(name);
        }
        votingToName[name] += votes;
    }

    function getVotes(string memory name) public view returns (uint256) {
        return votingToName[name];
    }

    function resetVotes() public {
        for (uint i; i < names.length; i++) {
            votingToName[names[i]] = 0;
        }
    }
}
