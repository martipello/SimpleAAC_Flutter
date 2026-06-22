import concurrent.futures
import json
import os
import re
import base64
import time
import sys
from openai import OpenAI

# ----------------------------------------------------
# CONFIGURATION
# ----------------------------------------------------
API_TOKEN = os.environ.get("OPENAI_API_KEY", "")
OUTPUT_DIR = "temp3/aac_images_cartoon"
PORTRAITS_DIR = "temp3/family"
MAX_WORKERS = 1

FAMILY = [
    {
        "name": "boy",
        "description": (
            "A small cheerful boy, round face, short dark brown hair, fair skin, "
            "wearing a bright yellow t-shirt and blue shorts. Big friendly eyes, rosy cheeks, small button nose."
        ),
    },
    {
        "name": "girl",
        "description": (
            "A teenage girl, taller and slimmer build, long dark brown hair worn down, fair skin, "
            "wearing a casual hoodie and jeans. Friendly eyes, light smile, relaxed confident pose."
        ),
    },
    {
        "name": "mum",
        "description": (
            "A woman in her 30s, warm light brown Indian skin tone, long straight dark hair, bright smile, "
            "wearing a modern colourful top and jeans. Medium height, warm expressive dark eyes."
        ),
    },
    {
        "name": "dad",
        "description": (
            "A man in his 30s, fair skin, short light brown hair, friendly face, broad shoulders, "
            "wearing a plain blue t-shirt. Big warm smile, clean shaven."
        ),
    },
    {
        "name": "nan",
        "description": (
            "An older Indian woman, warm golden-brown skin, grey hair in a traditional bun, "
            "wearing a bright colourful sari. Round glasses, soft kind eyes, warm gentle smile, slightly shorter stature."
        ),
    },
    {
        "name": "grandad",
        "description": (
            "An older Indian man, warm golden-brown skin, white hair and a full white beard, round belly, "
            "wearing a traditional kurta shirt. Warm crinkled eyes, big friendly grin."
        ),
    },
]

PORTRAIT_STYLE = (
    "Bright cheerful children's cartoon illustration. Flat 2D cartoon art, thick friendly black outlines, "
    "vibrant solid fill colours, no gradients, no shading, no photo-realism. White background, no scene or environment. "
    "Full body portrait, character standing upright with arms relaxed at sides, centred in frame, facing slightly toward the viewer. "
    "Character has empty hands — NO tablets, NO phones, NO devices, NO props, NO objects of any kind. "
    "STRICTLY NO TEXT or labels anywhere in the image."
)

client = OpenAI(api_key=API_TOKEN)

FULL_DATA_JSON = """
{
  "languages": [
    {
      "id": "en",
      "displayName": "English",
      "words": [
        {"text": "I", "type": "grammar", "subType": "pronouns"},
        {"text": "you", "type": "grammar", "subType": "pronouns"},
        {"text": "he", "type": "grammar", "subType": "pronouns"},
        {"text": "she", "type": "grammar", "subType": "pronouns"},
        {"text": "it", "type": "grammar", "subType": "pronouns"},
        {"text": "we", "type": "grammar", "subType": "pronouns"},
        {"text": "they", "type": "grammar", "subType": "pronouns"},
        {"text": "me", "type": "grammar", "subType": "pronouns"},
        {"text": "him", "type": "grammar", "subType": "pronouns"},
        {"text": "her", "type": "grammar", "subType": "pronouns"},
        {"text": "this", "type": "grammar", "subType": "pronouns"},
        {"text": "that", "type": "grammar", "subType": "pronouns"},
        {"text": "my", "type": "grammar", "subType": "pronouns"},
        {"text": "your", "type": "grammar", "subType": "pronouns"},
        {"text": "and", "type": "grammar", "subType": "conjunctions"},
        {"text": "but", "type": "grammar", "subType": "conjunctions"},
        {"text": "or", "type": "grammar", "subType": "conjunctions"},
        {"text": "because", "type": "grammar", "subType": "conjunctions"},
        {"text": "if", "type": "grammar", "subType": "conjunctions"},
        {"text": "so", "type": "grammar", "subType": "conjunctions"},
        {"text": "in", "type": "grammar", "subType": "prepositions"},
        {"text": "on", "type": "grammar", "subType": "prepositions"},
        {"text": "under", "type": "grammar", "subType": "prepositions"},
        {"text": "up", "type": "grammar", "subType": "prepositions"},
        {"text": "down", "type": "grammar", "subType": "prepositions"},
        {"text": "with", "type": "grammar", "subType": "prepositions"},
        {"text": "to", "type": "grammar", "subType": "prepositions"},
        {"text": "from", "type": "grammar", "subType": "prepositions"},
        {"text": "out", "type": "grammar", "subType": "prepositions"},
        {"text": "off", "type": "grammar", "subType": "prepositions"},
        {"text": "for", "type": "grammar", "subType": "prepositions"},
        {"text": "about", "type": "grammar", "subType": "prepositions"},
        {"text": "next to", "type": "grammar", "subType": "prepositions"},
        {"text": "behind", "type": "grammar", "subType": "prepositions"},
        {"text": "ing", "type": "grammar", "subType": "suffix"},
        {"text": "ed", "type": "grammar", "subType": "suffix"},
        {"text": "s", "type": "grammar", "subType": "suffix"},
        {"text": "er", "type": "grammar", "subType": "suffix"},
        {"text": "eat", "type": "actions", "subType": "action"},
        {"text": "drink", "type": "actions", "subType": "action"},
        {"text": "go", "type": "actions", "subType": "action"},
        {"text": "want", "type": "actions", "subType": "action"},
        {"text": "see", "type": "actions", "subType": "action"},
        {"text": "look", "type": "actions", "subType": "action"},
        {"text": "play", "type": "actions", "subType": "action"},
        {"text": "sleep", "type": "actions", "subType": "action"},
        {"text": "stop", "type": "actions", "subType": "action"},
        {"text": "come", "type": "actions", "subType": "action"},
        {"text": "make", "type": "actions", "subType": "action"},
        {"text": "take", "type": "actions", "subType": "action"},
        {"text": "open", "type": "actions", "subType": "action"},
        {"text": "close", "type": "actions", "subType": "action"},
        {"text": "sit", "type": "actions", "subType": "action"},
        {"text": "stand", "type": "actions", "subType": "action"},
        {"text": "walk", "type": "actions", "subType": "action"},
        {"text": "run", "type": "actions", "subType": "action"},
        {"text": "jump", "type": "actions", "subType": "action"},
        {"text": "wash", "type": "actions", "subType": "action"},
        {"text": "clean", "type": "actions", "subType": "action"},
        {"text": "read", "type": "actions", "subType": "action"},
        {"text": "write", "type": "actions", "subType": "action"},
        {"text": "draw", "type": "actions", "subType": "action"},
        {"text": "paint", "type": "actions", "subType": "action"},
        {"text": "sing", "type": "actions", "subType": "action"},
        {"text": "dance", "type": "actions", "subType": "action"},
        {"text": "swim", "type": "actions", "subType": "action"},
        {"text": "ride", "type": "actions", "subType": "action"},
        {"text": "drive", "type": "actions", "subType": "action"},
        {"text": "fly", "type": "actions", "subType": "action"},
        {"text": "climb", "type": "actions", "subType": "action"},
        {"text": "push", "type": "actions", "subType": "action"},
        {"text": "pull", "type": "actions", "subType": "action"},
        {"text": "throw", "type": "actions", "subType": "action"},
        {"text": "catch", "type": "actions", "subType": "action"},
        {"text": "kick", "type": "actions", "subType": "action"},
        {"text": "cook", "type": "actions", "subType": "action"},
        {"text": "bake", "type": "actions", "subType": "action"},
        {"text": "cut", "type": "actions", "subType": "action"},
        {"text": "glue", "type": "actions", "subType": "action"},
        {"text": "listen", "type": "actions", "subType": "action"},
        {"text": "talk", "type": "actions", "subType": "action"},
        {"text": "say", "type": "actions", "subType": "action"},
        {"text": "tell", "type": "actions", "subType": "action"},
        {"text": "ask", "type": "actions", "subType": "action"},
        {"text": "share", "type": "actions", "subType": "action"},
        {"text": "buy", "type": "actions", "subType": "action"},
        {"text": "find", "type": "actions", "subType": "action"},
        {"text": "hide", "type": "actions", "subType": "action"},
        {"text": "lose", "type": "actions", "subType": "action"},
        {"text": "win", "type": "actions", "subType": "action"},
        {"text": "smile", "type": "actions", "subType": "action"},
        {"text": "cry", "type": "actions", "subType": "action"},
        {"text": "laugh", "type": "actions", "subType": "action"},
        {"text": "cough", "type": "actions", "subType": "action"},
        {"text": "sneeze", "type": "actions", "subType": "action"},
        {"text": "hug", "type": "actions", "subType": "action"},
        {"text": "kiss", "type": "actions", "subType": "action"},
        {"text": "think", "type": "actions", "subType": "action"},
        {"text": "know", "type": "actions", "subType": "action"},
        {"text": "forget", "type": "actions", "subType": "action"},
        {"text": "remember", "type": "actions", "subType": "action"},
        {"text": "learn", "type": "actions", "subType": "action"},
        {"text": "teach", "type": "actions", "subType": "action"},
        {"text": "work", "type": "actions", "subType": "action"},
        {"text": "break", "type": "actions", "subType": "action"},
        {"text": "fix", "type": "actions", "subType": "action"},
        {"text": "build", "type": "actions", "subType": "action"},
        {"text": "drop", "type": "actions", "subType": "action"},
        {"text": "lift", "type": "actions", "subType": "action"},
        {"text": "carry", "type": "actions", "subType": "action"},
        {"text": "show", "type": "actions", "subType": "action"},
        {"text": "give", "type": "actions", "subType": "action"},
        {"text": "get", "type": "actions", "subType": "action"},
        {"text": "keep", "type": "actions", "subType": "action"},
        {"text": "hold", "type": "actions", "subType": "action"},
        {"text": "wait", "type": "actions", "subType": "action"},
        {"text": "brush", "type": "actions", "subType": "action"},
        {"text": "tie", "type": "actions", "subType": "action"},
        {"text": "dress", "type": "actions", "subType": "action"},
        {"text": "pack", "type": "actions", "subType": "action"},
        {"text": "fall", "type": "actions", "subType": "action"},
        {"text": "help", "type": "actions", "subType": "action"},
        {"text": "can", "type": "actions", "subType": "helping"},
        {"text": "will", "type": "actions", "subType": "helping"},
        {"text": "do", "type": "actions", "subType": "helping"},
        {"text": "did", "type": "actions", "subType": "helping"},
        {"text": "is", "type": "actions", "subType": "helping"},
        {"text": "am", "type": "actions", "subType": "helping"},
        {"text": "are", "type": "actions", "subType": "helping"},
        {"text": "was", "type": "actions", "subType": "helping"},
        {"text": "were", "type": "actions", "subType": "helping"},
        {"text": "have", "type": "actions", "subType": "helping"},
        {"text": "has", "type": "actions", "subType": "helping"},
        {"text": "had", "type": "actions", "subType": "helping"},
        {"text": "could", "type": "actions", "subType": "helping"},
        {"text": "would", "type": "actions", "subType": "helping"},
        {"text": "should", "type": "actions", "subType": "helping"},
        {"text": "may", "type": "actions", "subType": "helping"},
        {"text": "must", "type": "actions", "subType": "helping"},
        {"text": "hurt", "type": "actions", "subType": "strong"},
        {"text": "need", "type": "actions", "subType": "strong"},
        {"text": "good", "type": "describe", "subType": "adjectives"},
        {"text": "bad", "type": "describe", "subType": "adjectives"},
        {"text": "big", "type": "describe", "subType": "adjectives"},
        {"text": "little", "type": "describe", "subType": "adjectives"},
        {"text": "hot", "type": "describe", "subType": "adjectives"},
        {"text": "cold", "type": "describe", "subType": "adjectives"},
        {"text": "fast", "type": "describe", "subType": "adjectives"},
        {"text": "slow", "type": "describe", "subType": "adjectives"},
        {"text": "happy", "type": "describe", "subType": "adjectives"},
        {"text": "sad", "type": "describe", "subType": "adjectives"},
        {"text": "angry", "type": "describe", "subType": "adjectives"},
        {"text": "scared", "type": "describe", "subType": "adjectives"},
        {"text": "tired", "type": "describe", "subType": "adjectives"},
        {"text": "sick", "type": "describe", "subType": "adjectives"},
        {"text": "clean", "type": "describe", "subType": "adjectives"},
        {"text": "dirty", "type": "describe", "subType": "adjectives"},
        {"text": "wet", "type": "describe", "subType": "adjectives"},
        {"text": "dry", "type": "describe", "subType": "adjectives"},
        {"text": "soft", "type": "describe", "subType": "adjectives"},
        {"text": "hard", "type": "describe", "subType": "adjectives"},
        {"text": "heavy", "type": "describe", "subType": "adjectives"},
        {"text": "light", "type": "describe", "subType": "adjectives"},
        {"text": "new", "type": "describe", "subType": "adjectives"},
        {"text": "old", "type": "describe", "subType": "adjectives"},
        {"text": "beautiful", "type": "describe", "subType": "adjectives"},
        {"text": "ugly", "type": "describe", "subType": "adjectives"},
        {"text": "sweet", "type": "describe", "subType": "adjectives"},
        {"text": "sour", "type": "describe", "subType": "adjectives"},
        {"text": "salty", "type": "describe", "subType": "adjectives"},
        {"text": "loud", "type": "describe", "subType": "adjectives"},
        {"text": "quiet", "type": "describe", "subType": "adjectives"},
        {"text": "red", "type": "describe", "subType": "adjectives"},
        {"text": "blue", "type": "describe", "subType": "adjectives"},
        {"text": "green", "type": "describe", "subType": "adjectives"},
        {"text": "yellow", "type": "describe", "subType": "adjectives"},
        {"text": "black", "type": "describe", "subType": "adjectives"},
        {"text": "white", "type": "describe", "subType": "adjectives"},
        {"text": "orange", "type": "describe", "subType": "adjectives"},
        {"text": "purple", "type": "describe", "subType": "adjectives"},
        {"text": "pink", "type": "describe", "subType": "adjectives"},
        {"text": "brown", "type": "describe", "subType": "adjectives"},
        {"text": "gray", "type": "describe", "subType": "adjectives"},
        {"text": "broken", "type": "describe", "subType": "adjectives"},
        {"text": "empty", "type": "describe", "subType": "adjectives"},
        {"text": "full", "type": "describe", "subType": "adjectives"},
        {"text": "hungry", "type": "describe", "subType": "adjectives"},
        {"text": "thirsty", "type": "describe", "subType": "adjectives"},
        {"text": "funny", "type": "describe", "subType": "adjectives"},
        {"text": "boring", "type": "describe", "subType": "adjectives"},
        {"text": "scary", "type": "describe", "subType": "adjectives"},
        {"text": "brave", "type": "describe", "subType": "adjectives"},
        {"text": "mean", "type": "describe", "subType": "adjectives"},
        {"text": "kind", "type": "describe", "subType": "adjectives"},
        {"text": "easy", "type": "describe", "subType": "adjectives"},
        {"text": "difficult", "type": "describe", "subType": "adjectives"},
        {"text": "wrong", "type": "describe", "subType": "adjectives"},
        {"text": "right", "type": "describe", "subType": "adjectives"},
        {"text": "safe", "type": "describe", "subType": "adjectives"},
        {"text": "dangerous", "type": "describe", "subType": "adjectives"},
        {"text": "see", "type": "describe", "subType": "sense"},
        {"text": "hear", "type": "describe", "subType": "sense"},
        {"text": "smell", "type": "describe", "subType": "sense"},
        {"text": "taste", "type": "describe", "subType": "sense"},
        {"text": "touch", "type": "describe", "subType": "sense"},
        {"text": "feel", "type": "describe", "subType": "sense"},
        {"text": "excited", "type": "describe", "subType": "feeling"},
        {"text": "bored", "type": "describe", "subType": "feeling"},
        {"text": "worried", "type": "describe", "subType": "feeling"},
        {"text": "surprised", "type": "describe", "subType": "feeling"},
        {"text": "proud", "type": "describe", "subType": "feeling"},
        {"text": "jealous", "type": "describe", "subType": "feeling"},
        {"text": "lonely", "type": "describe", "subType": "feeling"},
        {"text": "nervous", "type": "describe", "subType": "feeling"},
        {"text": "calm", "type": "describe", "subType": "feeling"},
        {"text": "confused", "type": "describe", "subType": "feeling"},
        {"text": "frustrated", "type": "describe", "subType": "feeling"},
        {"text": "silly", "type": "describe", "subType": "feeling"},
        {"text": "smart", "type": "describe", "subType": "thought"},
        {"text": "crazy", "type": "describe", "subType": "thought"},
        {"text": "creative", "type": "describe", "subType": "thought"},
        {"text": "wise", "type": "describe", "subType": "thought"},
        {"text": "careful", "type": "describe", "subType": "thought"},
        {"text": "thank you", "type": "social", "subType": "phrases"},
        {"text": "please", "type": "social", "subType": "phrases"},
        {"text": "excuse me", "type": "social", "subType": "phrases"},
        {"text": "i don't know", "type": "social", "subType": "phrases"},
        {"text": "im sorry", "type": "social", "subType": "phrases"},
        {"text": "no thank you", "type": "social", "subType": "phrases"},
        {"text": "your turn", "type": "social", "subType": "phrases"},
        {"text": "my turn", "type": "social", "subType": "phrases"},
        {"text": "all done", "type": "social", "subType": "phrases"},
        {"text": "help please", "type": "social", "subType": "phrases"},
        {"text": "more please", "type": "social", "subType": "phrases"},
        {"text": "yes please", "type": "social", "subType": "phrases"},
        {"text": "like", "type": "social", "subType": "favourites"},
        {"text": "love", "type": "social", "subType": "favourites"},
        {"text": "hate", "type": "social", "subType": "favourites"},
        {"text": "favorite", "type": "social", "subType": "favourites"},
        {"text": "best", "type": "social", "subType": "favourites"},
        {"text": "worst", "type": "social", "subType": "favourites"},
        {"text": "hello", "type": "social", "subType": "greetings"},
        {"text": "bye bye", "type": "social", "subType": "greetings"},
        {"text": "good morning", "type": "social", "subType": "greetings"},
        {"text": "good night", "type": "social", "subType": "greetings"},
        {"text": "hi", "type": "social", "subType": "greetings"},
        {"text": "welcome", "type": "social", "subType": "greetings"},
        {"text": "see you later", "type": "social", "subType": "greetings"},
        {"text": "how are you", "type": "social", "subType": "greetings"},
        {"text": "mom", "type": "things", "subType": "people"},
        {"text": "dad", "type": "things", "subType": "people"},
        {"text": "brother", "type": "things", "subType": "people"},
        {"text": "sister", "type": "things", "subType": "people"},
        {"text": "baby", "type": "things", "subType": "people"},
        {"text": "grandma", "type": "things", "subType": "people"},
        {"text": "grandpa", "type": "things", "subType": "people"},
        {"text": "teacher", "type": "things", "subType": "people"},
        {"text": "doctor", "type": "things", "subType": "people"},
        {"text": "nurse", "type": "things", "subType": "people"},
        {"text": "friend", "type": "things", "subType": "people"},
        {"text": "boy", "type": "things", "subType": "people"},
        {"text": "girl", "type": "things", "subType": "people"},
        {"text": "man", "type": "things", "subType": "people"},
        {"text": "woman", "type": "things", "subType": "people"},
        {"text": "dentist", "type": "things", "subType": "people"},
        {"text": "firefighter", "type": "things", "subType": "people"},
        {"text": "student", "type": "things", "subType": "people"},
        {"text": "family", "type": "things", "subType": "people"},
        {"text": "dog", "type": "things", "subType": "animals"},
        {"text": "cat", "type": "things", "subType": "animals"},
        {"text": "bird", "type": "things", "subType": "animals"},
        {"text": "fish", "type": "things", "subType": "animals"},
        {"text": "horse", "type": "things", "subType": "animals"},
        {"text": "cow", "type": "things", "subType": "animals"},
        {"text": "pig", "type": "things", "subType": "animals"},
        {"text": "sheep", "type": "things", "subType": "animals"},
        {"text": "chicken", "type": "things", "subType": "animals"},
        {"text": "duck", "type": "things", "subType": "animals"},
        {"text": "lion", "type": "things", "subType": "animals"},
        {"text": "tiger", "type": "things", "subType": "animals"},
        {"text": "bear", "type": "things", "subType": "animals"},
        {"text": "elephant", "type": "things", "subType": "animals"},
        {"text": "monkey", "type": "things", "subType": "animals"},
        {"text": "giraffe", "type": "things", "subType": "animals"},
        {"text": "rabbit", "type": "things", "subType": "animals"},
        {"text": "mouse", "type": "things", "subType": "animals"},
        {"text": "frog", "type": "things", "subType": "animals"},
        {"text": "snake", "type": "things", "subType": "animals"},
        {"text": "turtle", "type": "things", "subType": "animals"},
        {"text": "spider", "type": "things", "subType": "animals"},
        {"text": "bee", "type": "things", "subType": "animals"},
        {"text": "butterfly", "type": "things", "subType": "animals"},
        {"text": "shark", "type": "things", "subType": "animals"},
        {"text": "whale", "type": "things", "subType": "animals"},
        {"text": "dolphin", "type": "things", "subType": "animals"},
        {"text": "penguin", "type": "things", "subType": "animals"},
        {"text": "owl", "type": "things", "subType": "animals"},
        {"text": "fox", "type": "things", "subType": "animals"},
        {"text": "tree", "type": "things", "subType": "nature"},
        {"text": "flower", "type": "things", "subType": "nature"},
        {"text": "grass", "type": "things", "subType": "nature"},
        {"text": "sun", "type": "things", "subType": "nature"},
        {"text": "moon", "type": "things", "subType": "nature"},
        {"text": "star", "type": "things", "subType": "nature"},
        {"text": "cloud", "type": "things", "subType": "nature"},
        {"text": "rain", "type": "things", "subType": "nature"},
        {"text": "snow", "type": "things", "subType": "nature"},
        {"text": "wind", "type": "things", "subType": "nature"},
        {"text": "sky", "type": "things", "subType": "nature"},
        {"text": "water", "type": "things", "subType": "nature"},
        {"text": "fire", "type": "things", "subType": "nature"},
        {"text": "rock", "type": "things", "subType": "nature"},
        {"text": "dirt", "type": "things", "subType": "nature"},
        {"text": "leaf", "type": "things", "subType": "nature"},
        {"text": "river", "type": "things", "subType": "nature"},
        {"text": "ocean", "type": "things", "subType": "nature"},
        {"text": "mountain", "type": "things", "subType": "nature"},
        {"text": "sand", "type": "things", "subType": "nature"},
        {"text": "apple", "type": "things", "subType": "food"},
        {"text": "banana", "type": "things", "subType": "food"},
        {"text": "grapes", "type": "things", "subType": "food"},
        {"text": "strawberry", "type": "things", "subType": "food"},
        {"text": "watermelon", "type": "things", "subType": "food"},
        {"text": "carrot", "type": "things", "subType": "food"},
        {"text": "broccoli", "type": "things", "subType": "food"},
        {"text": "potato", "type": "things", "subType": "food"},
        {"text": "tomato", "type": "things", "subType": "food"},
        {"text": "corn", "type": "things", "subType": "food"},
        {"text": "cucumber", "type": "things", "subType": "food"},
        {"text": "bread", "type": "things", "subType": "food"},
        {"text": "rice", "type": "things", "subType": "food"},
        {"text": "pasta", "type": "things", "subType": "food"},
        {"text": "pizza", "type": "things", "subType": "food"},
        {"text": "burger", "type": "things", "subType": "food"},
        {"text": "sandwich", "type": "things", "subType": "food"},
        {"text": "meat", "type": "things", "subType": "food"},
        {"text": "egg", "type": "things", "subType": "food"},
        {"text": "cheese", "type": "things", "subType": "food"},
        {"text": "yogurt", "type": "things", "subType": "food"},
        {"text": "soup", "type": "things", "subType": "food"},
        {"text": "salad", "type": "things", "subType": "food"},
        {"text": "cereal", "type": "things", "subType": "food"},
        {"text": "pancakes", "type": "things", "subType": "food"},
        {"text": "cookie", "type": "things", "subType": "food"},
        {"text": "cake", "type": "things", "subType": "food"},
        {"text": "ice cream", "type": "things", "subType": "food"},
        {"text": "candy", "type": "things", "subType": "food"},
        {"text": "chocolate", "type": "things", "subType": "food"},
        {"text": "chips", "type": "things", "subType": "food"},
        {"text": "popcorn", "type": "things", "subType": "food"},
        {"text": "snack", "type": "things", "subType": "food"},
        {"text": "milk", "type": "things", "subType": "drink"},
        {"text": "juice", "type": "things", "subType": "drink"},
        {"text": "tea", "type": "things", "subType": "drink"},
        {"text": "coffee", "type": "things", "subType": "drink"},
        {"text": "soda", "type": "things", "subType": "drink"},
        {"text": "hot chocolate", "type": "things", "subType": "drink"},
        {"text": "smoothie", "type": "things", "subType": "drink"},
        {"text": "head", "type": "things", "subType": "body"},
        {"text": "hair", "type": "things", "subType": "body"},
        {"text": "face", "type": "things", "subType": "body"},
        {"text": "eye", "type": "things", "subType": "body"},
        {"text": "ear", "type": "things", "subType": "body"},
        {"text": "nose", "type": "things", "subType": "body"},
        {"text": "mouth", "type": "things", "subType": "body"},
        {"text": "teeth", "type": "things", "subType": "body"},
        {"text": "tongue", "type": "things", "subType": "body"},
        {"text": "neck", "type": "things", "subType": "body"},
        {"text": "shoulder", "type": "things", "subType": "body"},
        {"text": "arm", "type": "things", "subType": "body"},
        {"text": "elbow", "type": "things", "subType": "body"},
        {"text": "hand", "type": "things", "subType": "body"},
        {"text": "finger", "type": "things", "subType": "body"},
        {"text": "thumb", "type": "things", "subType": "body"},
        {"text": "stomach", "type": "things", "subType": "body"},
        {"text": "leg", "type": "things", "subType": "body"},
        {"text": "knee", "type": "things", "subType": "body"},
        {"text": "foot", "type": "things", "subType": "body"},
        {"text": "toe", "type": "things", "subType": "body"},
        {"text": "back", "type": "things", "subType": "body"},
        {"text": "heart", "type": "things", "subType": "body"},
        {"text": "shirt", "type": "things", "subType": "clothes"},
        {"text": "pants", "type": "things", "subType": "clothes"},
        {"text": "shorts", "type": "things", "subType": "clothes"},
        {"text": "skirt", "type": "things", "subType": "clothes"},
        {"text": "dress", "type": "things", "subType": "clothes"},
        {"text": "jacket", "type": "things", "subType": "clothes"},
        {"text": "coat", "type": "things", "subType": "clothes"},
        {"text": "sweater", "type": "things", "subType": "clothes"},
        {"text": "pajamas", "type": "things", "subType": "clothes"},
        {"text": "underwear", "type": "things", "subType": "clothes"},
        {"text": "socks", "type": "things", "subType": "clothes"},
        {"text": "shoes", "type": "things", "subType": "clothes"},
        {"text": "boots", "type": "things", "subType": "clothes"},
        {"text": "hat", "type": "things", "subType": "clothes"},
        {"text": "cap", "type": "things", "subType": "clothes"},
        {"text": "gloves", "type": "things", "subType": "clothes"},
        {"text": "scarf", "type": "things", "subType": "clothes"},
        {"text": "swimsuit", "type": "things", "subType": "clothes"},
        {"text": "belt", "type": "things", "subType": "clothes"},
        {"text": "glasses", "type": "things", "subType": "clothes"},
        {"text": "house", "type": "things", "subType": "home"},
        {"text": "room", "type": "things", "subType": "home"},
        {"text": "kitchen", "type": "things", "subType": "home"},
        {"text": "bathroom", "type": "things", "subType": "home"},
        {"text": "bedroom", "type": "things", "subType": "home"},
        {"text": "living room", "type": "things", "subType": "home"},
        {"text": "door", "type": "things", "subType": "home"},
        {"text": "window", "type": "things", "subType": "home"},
        {"text": "wall", "type": "things", "subType": "home"},
        {"text": "floor", "type": "things", "subType": "home"},
        {"text": "bed", "type": "things", "subType": "home"},
        {"text": "pillow", "type": "things", "subType": "home"},
        {"text": "blanket", "type": "things", "subType": "home"},
        {"text": "table", "type": "things", "subType": "home"},
        {"text": "chair", "type": "things", "subType": "home"},
        {"text": "couch", "type": "things", "subType": "home"},
        {"text": "desk", "type": "things", "subType": "home"},
        {"text": "shelf", "type": "things", "subType": "home"},
        {"text": "closet", "type": "things", "subType": "home"},
        {"text": "lamp", "type": "things", "subType": "home"},
        {"text": "light", "type": "things", "subType": "home"},
        {"text": "tv", "type": "things", "subType": "home"},
        {"text": "computer", "type": "things", "subType": "home"},
        {"text": "phone", "type": "things", "subType": "home"},
        {"text": "clock", "type": "things", "subType": "home"},
        {"text": "mirror", "type": "things", "subType": "home"},
        {"text": "sink", "type": "things", "subType": "home"},
        {"text": "toilet", "type": "things", "subType": "home"},
        {"text": "shower", "type": "things", "subType": "home"},
        {"text": "bathtub", "type": "things", "subType": "home"},
        {"text": "fridge", "type": "things", "subType": "home"},
        {"text": "oven", "type": "things", "subType": "home"},
        {"text": "microwave", "type": "things", "subType": "home"},
        {"text": "plate", "type": "things", "subType": "home"},
        {"text": "bowl", "type": "things", "subType": "home"},
        {"text": "cup", "type": "things", "subType": "home"},
        {"text": "fork", "type": "things", "subType": "home"},
        {"text": "spoon", "type": "things", "subType": "home"},
        {"text": "knife", "type": "things", "subType": "home"},
        {"text": "trash can", "type": "things", "subType": "home"},
        {"text": "key", "type": "things", "subType": "home"},
        {"text": "toy", "type": "things", "subType": "home"},
        {"text": "book", "type": "things", "subType": "home"},
        {"text": "backpack", "type": "things", "subType": "home"},
        {"text": "towel", "type": "things", "subType": "home"},
        {"text": "soap", "type": "things", "subType": "home"},
        {"text": "toothbrush", "type": "things", "subType": "home"},
        {"text": "toothpaste", "type": "things", "subType": "home"},
        {"text": "shampoo", "type": "things", "subType": "home"},
        {"text": "paper", "type": "things", "subType": "home"},
        {"text": "pencil", "type": "things", "subType": "home"},
        {"text": "pen", "type": "things", "subType": "home"},
        {"text": "crayons", "type": "things", "subType": "home"},
        {"text": "scissors", "type": "things", "subType": "home"},
        {"text": "bus", "type": "things", "subType": "travel"},
        {"text": "train", "type": "things", "subType": "travel"},
        {"text": "motorcycle", "type": "things", "subType": "travel"},
        {"text": "truck", "type": "things", "subType": "travel"},
        {"text": "boat", "type": "things", "subType": "travel"},
        {"text": "ship", "type": "things", "subType": "travel"},
        {"text": "subway", "type": "things", "subType": "travel"},
        {"text": "taxi", "type": "things", "subType": "travel"},
        {"text": "helicopter", "type": "things", "subType": "travel"},
        {"text": "stroller", "type": "things", "subType": "travel"},
        {"text": "suitcase", "type": "things", "subType": "travel"},
        {"text": "ticket", "type": "things", "subType": "travel"},
        {"text": "map", "type": "things", "subType": "travel"},
        {"text": "hospital", "type": "things", "subType": "places"},
        {"text": "school", "type": "things", "subType": "places"},
        {"text": "park", "type": "things", "subType": "places"},
        {"text": "store", "type": "things", "subType": "places"},
        {"text": "hospital", "type": "things", "subType": "places"},
        {"text": "library", "type": "things", "subType": "places"},
        {"text": "restaurant", "type": "things", "subType": "places"},
        {"text": "beach", "type": "things", "subType": "places"},
        {"text": "pool", "type": "things", "subType": "places"},
        {"text": "playground", "type": "things", "subType": "places"},
        {"text": "zoo", "type": "things", "subType": "places"},
        {"text": "farm", "type": "things", "subType": "places"},
        {"text": "garden", "type": "things", "subType": "places"},
        {"text": "yard", "type": "things", "subType": "places"},
        {"text": "office", "type": "things", "subType": "places"},
        {"text": "theater", "type": "things", "subType": "places"},
        {"text": "museum", "type": "things", "subType": "places"},
        {"text": "picture", "type": "things", "subType": "art"},
        {"text": "drawing", "type": "things", "subType": "art"},
        {"text": "painting", "type": "things", "subType": "art"},
        {"text": "clay", "type": "things", "subType": "art"},
        {"text": "markers", "type": "things", "subType": "art"},
        {"text": "chalk", "type": "things", "subType": "art"},
        {"text": "stickers", "type": "things", "subType": "art"},
        {"text": "stamp", "type": "things", "subType": "art"},
        {"text": "music", "type": "things", "subType": "music"},
        {"text": "song", "type": "things", "subType": "music"},
        {"text": "radio", "type": "things", "subType": "music"},
        {"text": "piano", "type": "things", "subType": "music"},
        {"text": "guitar", "type": "things", "subType": "music"},
        {"text": "drums", "type": "things", "subType": "music"},
        {"text": "flute", "type": "things", "subType": "music"},
        {"text": "bell", "type": "things", "subType": "music"},
        {"text": "game", "type": "things", "subType": "games"},
        {"text": "ball", "type": "things", "subType": "games"},
        {"text": "blocks", "type": "things", "subType": "games"},
        {"text": "puzzle", "type": "things", "subType": "games"},
        {"text": "doll", "type": "things", "subType": "games"},
        {"text": "lego", "type": "things", "subType": "games"},
        {"text": "cards", "type": "things", "subType": "games"},
        {"text": "dice", "type": "things", "subType": "games"},
        {"text": "swing", "type": "things", "subType": "games"},
        {"text": "slide", "type": "things", "subType": "games"},
        {"text": "sandbox", "type": "things", "subType": "games"},
        {"text": "bubble", "type": "things", "subType": "games"},
        {"text": "party", "type": "things", "subType": "occasions"},
        {"text": "birthday", "type": "things", "subType": "occasions"},
        {"text": "holiday", "type": "things", "subType": "occasions"},
        {"text": "christmas", "type": "things", "subType": "occasions"},
        {"text": "halloween", "type": "things", "subType": "occasions"},
        {"text": "wedding", "type": "things", "subType": "occasions"},
        {"text": "gift", "type": "things", "subType": "occasions"}
      ]
    }
  ]
}
"""


def get_explicit_scene_description(word, item_type, sub_type):
    w = word.lower().strip()

    colors = ["red", "blue", "green", "yellow", "black", "white", "orange", "purple", "pink", "brown", "gray"]
    if w in colors:
        return (
            f"One single clean cartoon stick figure character standing and holding out an oversized, prominent, perfectly round circle shape. "
            f"The circle shape must be filled completely with a bright, vibrant solid flat coat of the color {w}. "
            f"The character itself remains a clean white fill with a black outline, ensuring the colored circle is the main focus."
        )

    if sub_type == "suffix":
        return (
            f"A single cartoon stick figure character holding up a large clean speech bubble. "
            f"Inside the bubble is a simple visual symbol representing the concept of adding '{w}' to a word — "
            f"shown as an arrow pointing to an extended shape or a sequence of two simple shapes joined together. No text or letters."
        )

    exceptions = {
        "buy": "A cartoon stick figure character standing at a counter, handing a single clean round coin to another character to purchase a generic item.",
        "airport": "A simple exterior line drawing of a large building terminal with a control tower, and one single airplane parked cleanly on the ground outside.",
        "store": "A simple building structure with a prominent window display showing generic shapes, and an open front door indicator.",
        "wall": "A clean, simple pattern of bricks stacked in alternating rows forming a standard wall section. Entirely static object. No faces, no characters, no heads.",
        "soup": "A simple profile view outline of a bowl containing steaming hot soup with a spoon resting inside it. No faces, no human stick figures.",
        "and": "Two separate simple geometric shapes (a circle next to a square) connected by a clear plus symbol (+) hovering between them.",
        "but": "A line split down the center, on the left a happy character, on the right a sad character, representing a contrasting alternative.",
        "because": "A character pointing at a large, prominent question mark, which leads cleanly into a lightbulb shape.",
        "if": "A character standing at a fork in a path that splits into two clean branches labeled with simple arrow signs.",
        "so": "A character pushing a large heavy block, which cleanly results in the block sliding forward down a slope.",
        "in": "A character sitting entirely inside a transparent simple open outline of a box.",
        "on": "A character sitting completely on top of a flat table surface outline.",
        "under": "A character crouching completely beneath the structure outline of a clean table.",
        "this": "A character standing immediately next to a small ball, pointing a finger directly down onto it.",
        "that": "A character pointing its arm straight out towards a small ball located far away across the scene.",
    }

    if w in exceptions:
        return exceptions[w]

    if sub_type == "pronouns":
        if w in ["i", "me", "my"]:
            return "One single character standing perfectly alone, pointing its index finger directly at its own chest."
        if w in ["you", "your"]:
            return "One single character standing front-facing, pointing its index finger directly forward out at the viewer."
        if w in ["she", "her"]:
            return "Two distinct characters side-by-side. The figure on the right clearly wears a clean triangle-skirt dress outline. A separate black arrow points cleanly at the dress figure."
        if w in ["he", "him"]:
            return "Two distinct characters side-by-side. The figure on the right wears simple pant outlines. A separate black arrow points cleanly at the trouser-wearing figure."
        if w in ["we"]:
            return "Three friendly characters standing closely together arms-linked, forming a cooperative group."
        if w in ["they"]:
            return "Two neutral characters standing grouped together on the right side of the frame, with the viewer observing them from a slight distance."

    if item_type == "actions" or sub_type in ["action", "helping", "strong"]:
        return f"One single character actively executing the literal movement of '{w}' clearly and simply. The figure has a perfectly round circle head and clean tubular limbs."

    if sub_type in ["food", "animals", "travel", "drink"] and w not in ["soup", "salad", "meat"]:
        if sub_type == "travel":
            return f"A clean, simple vehicle icon of a '{w}'. The front windshield area features two small solid black dot eyes and an integrated happy smile line across the front bumper."
        if w in ["yogurt", "milk", "cereal", "soda"]:
            return f"A simple product container cup or carton representing '{w}'. The main front surface wall of the container features two small solid black dot eyes and an integrated happy smile line."
        return f"A clean, simple representation of a single '{w}' centered cleanly. The item features two simple solid black dot eyes and a happy smile line embedded directly onto its body surface."

    if item_type == "things" or sub_type in ["nature", "clothes", "home", "body", "places", "art", "music", "games", "occasions"]:
        return f"Only one isolated, clean structural graphic object of a '{w}' centered in the canvas. Completely static object layout. Strictly NO eyes, NO smiles, NO faces, and NO human figures."

    return f"A clear, self-explanatory cartoon stick-figure scene explicitly visualizing the concept: '{w}'."


def generate_and_save_image(word_obj):
    word = word_obj.get("text")
    if not word:
        return

    item_type = word_obj.get("type", "")
    sub_type = word_obj.get("subType", "")

    safe_word = re.sub(r"[^\w\-_]", "_", word.lower())
    filename = os.path.join(OUTPUT_DIR, f"{safe_word}.png")

    # Leave your preferred files (rabbit.png, remember.png) alone in the folder so they are not replaced.
    # Manually delete you.png, your.png, and pull.png to force their clean regeneration.
    if os.path.exists(filename):
        return

    scene_context = get_explicit_scene_description(word, item_type, sub_type)

    style_description = (
        "Bright, cheerful children's cartoon icon illustration. "
        "Flat 2D cartoon art with thick, friendly black outlines and vibrant solid fill colors — no gradients, no shading, no photo-realism. "
        "Characters are expressive round-headed cartoon figures with large friendly eyes, rosy cheeks, and simple cheerful expressions. "
        "Use a limited but vivid color palette: warm skin tones, bright primary and secondary colors for clothing and objects. "
        "White background — absolutely no scene backgrounds, no ground lines, no sky, no environment. Subject floats on plain white. "
        "STRICTLY NO TEXT, labels, letters, or words of any kind anywhere in the image. "
        "Objects and animals should be cute, rounded, and friendly in shape — avoid sharp angles. "
        "Any arrows must be a single clean rounded stroke with a simple open V-shaped arrowhead — no filled or outlined arrow shapes. "
        "CRITICAL: clothes, buildings, and inanimate objects must NOT have faces. Only living characters and animals get expressions. "
        "Bold, clear, single focal subject centered in the frame. Fun and engaging for young children. Cartoon icon of: "
    )

    prompt = f"{style_description} {scene_context}"

    for attempt in range(5):
        try:
            response = client.images.generate(
                model="gpt-image-1",
                prompt=prompt,
                n=1,
                size="1024x1024",
                quality="low",
                background="opaque",
            )

            b64_data = response.data[0].b64_json
            if not b64_data:
                return

            img_bytes = base64.b64decode(b64_data)
            with open(filename, "wb") as handler:
                handler.write(img_bytes)
            print(f"Successfully generated clean single-icon for: '{word}'")
            return

        except Exception as e:
            if "429" in str(e):
                wait = 15 * (attempt + 1)
                print(f"Rate limited on '{word}', retrying in {wait}s...")
                time.sleep(wait)
            else:
                print(f"Failed for '{word}': {e}")
                return


def generate_portrait(member):
    filename = os.path.join(PORTRAITS_DIR, f"{member['name']}.png")
    if os.path.exists(filename):
        print(f"Skipping {member['name']} — already exists")
        return
    prompt = f"{PORTRAIT_STYLE} Character: {member['description']}"
    for attempt in range(5):
        try:
            response = client.images.generate(
                model="gpt-image-1",
                prompt=prompt,
                n=1,
                size="1024x1024",
                quality="low",
                background="opaque",
            )
            b64_data = response.data[0].b64_json
            if not b64_data:
                return
            img_bytes = base64.b64decode(b64_data)
            with open(filename, "wb") as f:
                f.write(img_bytes)
            print(f"Generated portrait: {member['name']}")
            return
        except Exception as e:
            if "429" in str(e):
                wait = 15 * (attempt + 1)
                print(f"Rate limited on {member['name']}, retrying in {wait}s...")
                time.sleep(wait)
            else:
                print(f"Failed for {member['name']}: {e}")
                return


def main():
    if "--portraits" in sys.argv:
        os.makedirs(PORTRAITS_DIR, exist_ok=True)
        for member in FAMILY:
            generate_portrait(member)
        print("\nPortraits complete.")
        return

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    data = json.loads(FULL_DATA_JSON)
    word_objects = data["languages"][0]["words"][:10]
    print(f"Loaded all {len(word_objects)} entries seamlessly.")

    with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        executor.map(generate_and_save_image, word_objects)

    print("\nBatch execution complete.")


if __name__ == "__main__":
    main()