document.addEventListener("DOMContentLoaded", function () {
    let selectedMood = null;
    let selectedEmotion = null;
    const continueBtn = document.getElementById("continue-btn");
    if (continueBtn) {
        continueBtn.style.display = "none"; // Hide initially
    } else {
        console.error("Continue button not found!");
    }

    // Function to handle selection
    function handleSelection(category, selectedElement) {
        console.log("Handling selection for category:", category);  // Debugging output
        
        // Reset previous selection's opacity and class
        if (category === "mood" && selectedMood) {
            selectedMood.classList.remove("is-selected");
            selectedMood.style.opacity = ""; // Remove inline opacity
        }
        if (category === "emotion" && selectedEmotion) {
            selectedEmotion.classList.remove("is-selected");
            selectedEmotion.style.opacity = ""; // Remove inline opacity
        }

        // Apply selected state to the new selection
        selectedElement.classList.add("is-selected");
        selectedElement.style.opacity = "0.6"; // Apply selected opacity

        // Update selected elements
        if (category === "mood") {
            selectedMood = selectedElement;
        } else if (category === "emotion") {
            selectedEmotion = selectedElement;
        }

        // Show "Continue" button only when both mood and emotion are selected
        if (selectedMood && selectedEmotion) {
            continueBtn.style.display = "block"; // Show the Continue button
            console.log("Both mood and emotion are selected, showing the Continue button.");  // Debugging output
        } else {
            continueBtn.style.display = "none"; // Ensure it's hidden if not both selected
            console.log("Continue button remains hidden, waiting for both mood and emotion to be selected.");  // Debugging output
        }
    }

    console.log("Mood selected:", selectedMood);
console.log("Emotion selected:", selectedEmotion);

    // Add event listeners to mood emojis
    document.querySelectorAll(".mood-emoji").forEach(emoji => {
        emoji.addEventListener("click", function () {
            console.log("Mood selected:", this); // Debugging output
            handleSelection("mood", this);
        });
    });

    // Add event listeners to emotion emojis
    document.querySelectorAll(".emotion-emoji").forEach(emoji => {
        emoji.addEventListener("click", function () {
            console.log("Emotion selected:", this); // Debugging output
            handleSelection("emotion", this);
        });
    });

    // Handle "Continue" button click
    continueBtn.addEventListener("click", function () {
        if (selectedMood && selectedEmotion) {
            const moodID = selectedMood.getAttribute("data-moodid");
            const emotionID = selectedEmotion.getAttribute("data-emotionid");
    
            console.log("Navigating to mood-page.html with:", moodID, emotionID); // Debugging output
    
            if (moodID && emotionID) {
                window.location.href = `mood-page.html?moodID=${encodeURIComponent(moodID)}&emotionID=${encodeURIComponent(emotionID)}`;
            } else {
                console.error("Missing moodID or emotionID.");
            }
        } else {
            console.error("Mood or emotion not selected yet.");
        }
    });
});

 //Handle the journal entry box and send to history
 document.getElementById("submit-entry").addEventListener("click", async function () {
    const urlParams = new URLSearchParams(window.location.search);
    const journalEntry = document.getElementById("journal-entry").value;
    const moodID = urlParams.get("moodID");
    const emotionID = urlParams.get("emotionID");

    if (!journalEntry.trim()) {
        showFeedbackMessage("Please write a journal entry before submitting.", "danger");
        return;
    }

    if (!moodID || !emotionID) {
        showFeedbackMessage("Mood and Emotion are required to submit an entry.", "danger");
        return;
    }

    const entryData = {
        moodID: moodID,
        emotionID: emotionID,
        journalEntry: journalEntry,
    };

    try {
        const response = await fetch("http://127.0.0.1:5002/submit-entry", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(entryData),
        });

        const data = await response.json();
        if (response.ok) {
            showFeedbackMessage("Your journal entry was successfully submitted.", "success");
            document.getElementById("journal-entry").value = ""; // Clear the text area
        } else {
            showFeedbackMessage("Error submitting journal entry: " + data.error, "danger");
        }
    } catch (error) {
        console.error("Error submitting entry:", error);
        showFeedbackMessage("Error submitting your entry. Please try again.", "danger");
    }
});

// Function to show feedback messages
function showFeedbackMessage(message, type) {
    const feedbackMessage = document.getElementById("feedback-message");
    feedbackMessage.style.display = "block";
    feedbackMessage.className = `alert alert-${type}`;
    feedbackMessage.innerText = message;
}
