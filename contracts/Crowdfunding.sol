// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Crowdfunding {
    struct Campaign {
        string title;
        string description;
        address payable benefactor;
        uint goal;
        uint deadline;
        uint amountRaised;
        bool ended;
    }
    // Individual campaign number
    mapping(uint => Campaign) public campaigns;
    // new number created for campaign
    uint public campaignNumber;

    // event to notify when a campaign is newly created
    event NewCampaignCreated(uint campaignId, string title, string description, address benefactor, uint goal, uint deadline);
    // event to notify when donation is received
    event DonationReceived(uint campaignId, address donor, uint amount);
    // event to notify when a campaign has ended
    event CampaignEnded(uint campaignId, address benefactor, uint amountRaised);

    // variable that stores owner
    address public owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // constructor that sets ownser when the contract is deployed
    constructor() {
        owner = msg.sender;
    }

    // function that will be used to create a new campaign
    function createCampaign(string memory _title, string memory _description, address payable _benefactor, uint _goal, uint _CampaignDurationInSeconds) public {
        require(_goal > 0, "Campaign Goal should be greater than 0");
        require(_CampaignDurationInSeconds > 0, "Camapaign Duration should be greater than 0");
        
        campaignNumber++;
        uint deadline = block.timestamp + _CampaignDurationInSeconds;

        campaigns[campaignNumber] = Campaign({
            title: _title,
            description: _description,
            benefactor: _benefactor,
            goal: _goal,
            deadline: deadline,
            amountRaised: 0,
            ended: false
        });

        // emit event when new campaign is created
        emit NewCampaignCreated(campaignNumber, _title, _description, _benefactor, _goal, deadline);
    }

    // function that will be used to donate to a campaign
    function donateToCampaign(uint _campaignId)public payable{
        Campaign storage campaign = campaigns[_campaignId]; 
        require(block.timestamp <= campaign.deadline, "Campaign is no longer going on");
        require(msg.value > 0, "Donation amount must be greater than 0");
        require(campaign.ended == false, "Campaign already ended");

        // increase value of amount raised
        campaign.amountRaised += msg.value;
        // notify campaign donation has been received
        emit DonationReceived(_campaignId, msg.sender, msg.value);
    }
    
    // function that will be used to end campaig
    function endCampaign(uint _campaignId) public {
        // get campaign from storage
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp > campaign.deadline, "The Campaign is still going on");
        require(campaign.ended == false, "The Campaign already ended");

        campaign.ended = true;

        uint amount = campaign.amountRaised;
        campaign.amountRaised = 0;
        // Transfer the collected amount to the benefactor
        campaign.benefactor.transfer(amount);

        // notify if a campaign has ended
        emit CampaignEnded(_campaignId, campaign.benefactor, amount);
    }

    // withdraw remaining funds from contract
    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        // transfer the remaining money to the owner
        payable(owner).transfer(balance);
    }
}