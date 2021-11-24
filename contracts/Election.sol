pragma solidity 0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Read/write Candidates
    mapping(uint256 => Candidate) public candidates;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates Count
    uint256 public candidatesCount;

    // string public condidate;
    constructor() public {
        addCandidate("Ibrahim");
        addCandidate("Ibtihal");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    //the event to be triggered when nedded
    event votedEvent(uint256 indexed _candidateId);

    function vote(uint256 _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
