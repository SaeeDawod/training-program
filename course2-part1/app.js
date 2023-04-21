const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();

// Replace with your contract's ABI and address
const contractAbi = [...];
const contractAddress = "0x...";

const contract = new ethers.Contract(contractAddress, contractAbi, signer);

const betInput = document.getElementById("bet");
const pointsRiskedInput = document.getElementById("pointsRisked");
const placeBetButton = document.getElementById("placeBetButton");
const claimInitialPointsButton = document.getElementById("claimInitialPointsButton");
const pointsDisplay = document.getElementById("points");
const gameResults = document.getElementById("gameResults");

async function getPoints() {
    const address = await signer.getAddress();
    const points = await contract.points(address);
    pointsDisplay.innerText = points.toString();
}

placeBetButton.addEventListener("click", async () => {
    const bet = parseInt(betInput.value);
    const pointsRisked = parseInt(pointsRiskedInput.value);

    try {
        const tx = await contract.placeBet(bet, pointsRisked);
        await tx.wait();
        getPoints();
    } catch (error) {
        console.error(error);
    }
});

claimInitialPointsButton.addEventListener("click", async () => {
    try {
        const tx = await contract.claimInitialPoints();
       
        await tx.wait();
        getPoints();
    } catch (error) {
        console.error(error);
    }
});

contract.on("BetPlaced", (user, bet, pointsRisked, event) => {
    const listItem = document.createElement("li");
    listItem.innerText = `You placed a bet of ${bet} with ${pointsRisked} points risked.`;
    gameResults.appendChild(listItem);
});

contract.on("BetResult", (user, won, pointsWonOrLost, event) => {
    const listItem = document.createElement("li");
    listItem.innerText = won ? `You won! You gained ${pointsWonOrLost} points.` : `You lost. You lost ${pointsWonOrLost} points.`;
    gameResults.appendChild(listItem);
    getPoints();
});

async function init() {
    await window.ethereum.enable();
    getPoints();
}

init();
