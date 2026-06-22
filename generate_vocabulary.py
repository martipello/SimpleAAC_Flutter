import json

# Define our vocabulary base categorized by type and subType
# Structure: (word, is_core, [related_ids])
vocabulary_source = {
    "grammar": {
        "pronouns": [
            ("I", True, ["action-want", "action-go", "action-like", "action-see"]),
            ("you", True, ["action-want", "action-go", "action-like", "action-help"]),
            ("he", True, ["action-is", "action-go", "action-play"]),
            ("she", True, ["action-is", "action-go", "action-play"]),
            ("it", True, ["action-is", "describe-good", "describe-broken"]),
            ("we", True, ["action-want", "action-go", "social-hello"]),
            ("they", True, ["action-are", "action-go"]),
            ("me", True, ["action-give", "action-help"]),
            ("him", False, ["action-give", "action-tell"]),
            ("her", False, ["action-give", "action-tell"]),
            ("this", True, ["action-is", "describe-good"]),
            ("that", True, ["action-is", "describe-bad"]),
            ("my", True, ["thing-home", "thing-family", "thing-body"]),
            ("your", True, ["thing-home", "thing-turn"])
        ],
        "conjunctions": [
            ("and", True, []), ("but", True, []), ("or", True, []), 
            ("because", True, []), ("if", True, []), ("so", True, [])
        ],
        "prepositions": [
            ("in", True, ["thing-home", "thing-box"]),
            ("on", True, ["thing-table", "thing-chair"]),
            ("under", True, ["thing-table", "thing-bed"]),
            ("up", True, ["action-go", "action-look"]),
            ("down", True, ["action-sit", "action-fall"]),
            ("with", True, ["grammar-me", "grammar-you"]),
            ("to", True, ["thing-school", "thing-park"]),
            ("from", True, ["thing-home"]),
            ("out", True, ["action-go"]),
            ("off", True, ["thing-light", "thing-tv"]),
            ("for", True, ["grammar-you", "grammar-me"]),
            ("about", False, []), ("next to", False, []), ("behind", False, [])
        ],
        "suffix": [
            ("ing", True, []), ("ed", True, []), ("s", True, []), ("er", False, [])
        ]
    },
    "actions": {
        "action": [
            ("eat", True, ["thing-food", "thing-apple", "thing-banana", "thing-cookie"]),
            ("drink", True, ["thing-water", "thing-milk", "thing-juice"]),
            ("go", True, ["thing-home", "thing-park", "thing-school", "thing-outside"]),
            ("want", True, ["thing-toy", "thing-food", "thing-water"]),
            ("see", True, ["thing-animal", "thing-bird", "thing-tv"]),
            ("look", True, ["grammar-at", "thing-picture"]),
            ("play", True, ["thing-game", "thing-toy", "thing-ball"]),
            ("sleep", True, ["thing-bed", "describe-tired"]),
            ("stop", True, ["action-go", "action-play"]),
            ("come", True, ["prepositions-here", "prepositions-in"]),
            ("make", True, ["thing-art", "thing-food"]),
            ("take", True, ["thing-toy", "thing-pill"]),
            ("open", True, ["thing-door", "thing-box", "thing-window"]),
            ("close", True, ["thing-door", "thing-window"]),
            ("sit", True, ["thing-chair", "prepositions-down"]),
            ("stand", True, ["prepositions-up"]),
            ("walk", False, ["thing-park", "thing-outside"]),
            ("run", False, ["thing-outside", "thing-park"]),
            ("jump", False, ["thing-bed", "thing-trampoline"]),
            ("wash", False, ["thing-hands", "thing-body", "thing-face"]),
            ("clean", False, ["thing-room", "thing-house"]),
            ("read", False, ["thing-book", "thing-story"]),
            ("write", False, ["thing-paper", "thing-letter"]),
            ("draw", False, ["thing-picture", "thing-art"]),
            ("paint", False, ["thing-art", "thing-picture"]),
            ("sing", False, ["thing-music", "thing-song"]),
            ("dance", False, ["thing-music"]),
            ("swim", False, ["thing-pool", "thing-beach"]),
            ("ride", False, ["thing-bike", "thing-car", "thing-bus"]),
            ("drive", False, ["thing-car"]),
            ("fly", False, ["thing-plane", "thing-bird"]),
            ("climb", False, ["thing-tree", "thing-stairs"]),
            ("push", False, ["thing-door", "thing-swing"]),
            ("pull", False, ["thing-door", "thing-wagon"]),
            ("throw", False, ["thing-ball"]),
            ("catch", False, ["thing-ball"]),
            ("kick", False, ["thing-ball"]),
            ("cook", False, ["thing-kitchen", "thing-food"]),
            ("bake", False, ["thing-cake", "thing-cookie"]),
            ("cut", False, ["thing-paper", "thing-food"]),
            ("glue", False, ["thing-paper", "thing-art"]),
            ("listen", False, ["thing-music", "thing-teacher"]),
            ("talk", False, ["grammar-you", "thing-friend"]),
            ("say", True, ["thing-word"]),
            ("tell", False, ["thing-story", "thing-secret"]),
            ("ask", False, ["thing-question"]),
            ("share", False, ["thing-toy", "thing-food"]),
            ("buy", False, ["thing-store", "thing-toy"]),
            ("sell", False, []),
            ("find", False, ["thing-toy", "thing-key"]),
            ("hide", False, ["prepositions-under", "thing-box"]),
            ("lose", False, ["thing-toy", "thing-game"]),
            ("win", False, ["thing-game"]),
            ("smile", False, ["describe-happy"]),
            ("cry", False, ["describe-sad"]),
            ("laugh", False, ["describe-funny"]),
            ("cough", False, ["describe-sick"]),
            ("sneeze", False, ["describe-sick"]),
            ("hug", False, ["thing-mom", "thing-dad"]),
            ("kiss", False, ["thing-mom"]),
            ("think", True, []),
            ("know", True, []),
            ("forget", False, []),
            ("remember", False, []),
            ("learn", False, ["thing-school"]),
            ("teach", False, ["thing-school"]),
            ("work", False, ["thing-office", "thing-computer"]),
            ("break", False, ["thing-toy", "thing-glass"]),
            ("fix", False, ["thing-toy", "thing-car"]),
            ("build", False, ["thing-blocks", "thing-lego"]),
            ("drop", False, ["thing-cup", "thing-ball"]),
            ("lift", False, ["thing-box"]),
            ("carry", False, ["thing-bag"]),
            ("show", True, ["thing-picture", "thing-toy"]),
            ("give", True, ["grammar-me", "thing-toy"]),
            ("get", True, ["thing-water", "thing-toy"]),
            ("keep", False, []),
            ("hold", False, ["thing-hand"]),
            ("wait", True, []),
            ("wash", False, ["thing-hands"]),
            ("brush", False, ["thing-teeth", "thing-hair"]),
            ("comb", False, ["thing-hair"]),
            ("tie", False, ["thing-shoes"]),
            ("dress", False, ["thing-clothes"]),
            ("undress", False, ["thing-clothes"]),
            ("pack", False, ["thing-bag", "thing-suitcase"]),
            ("unpack", False, ["thing-bag"])
        ],
        "helping": [
            ("can", True, []), ("will", True, []), ("do", True, []), 
            ("did", True, []), ("is", True, []), ("am", True, []), 
            ("are", True, []), ("was", True, []), ("were", True, []), 
            ("have", True, []), ("has", True, []), ("had", True, []),
            ("could", False, []), ("would", False, []), ("should", False, []),
            ("may", False, []), ("must", False, [])
        ],
        "strong": [
            ("help", True, ["grammar-me", "action-fix"]),
            ("stop", True, []),
            ("hurt", True, ["thing-body", "thing-arm", "thing-leg"]),
            ("need", True, ["thing-water", "thing-bathroom", "action-help"])
        ]
    },
    "describe": {
        "adjectives": [
            ("good", True, []), ("bad", True, []), ("big", True, []), 
            ("little", True, []), ("hot", True, ["thing-food", "thing-stove"]), 
            ("cold", True, ["thing-water", "thing-ice"]), ("fast", False, []), 
            ("slow", False, []), ("happy", True, []), ("sad", True, []), 
            ("angry", False, []), ("scared", False, []), ("tired", True, ["action-sleep"]),
            ("sick", False, ["thing-doctor"]), ("clean", False, []), ("dirty", False, []),
            ("wet", False, ["thing-water"]), ("dry", False, []), ("soft", False, []), 
            ("hard", False, []), ("heavy", False, []), ("light", False, []),
            ("new", False, []), ("old", False, []), ("beautiful", False, []), 
            ("ugly", False, []), ("sweet", False, ["thing-cookie", "thing-candy"]), 
            ("sour", False, ["thing-lemon"]), ("salty", False, ["thing-chips"]), 
            ("loud", False, ["thing-music"]), ("quiet", False, []),
            ("red", False, []), ("blue", False, []), ("green", False, []), 
            ("yellow", False, []), ("black", False, []), ("white", False, []),
            ("orange", False, []), ("purple", False, []), ("pink", False, []), 
            ("brown", False, []), ("gray", False, []), ("bright", False, []),
            ("dark", False, []), ("broken", False, ["thing-toy"]), 
            ("empty", False, ["thing-cup"]), ("full", False, ["thing-cup"]),
            ("hungry", True, ["action-eat"]), ("thirsty", True, ["action-drink"]),
            ("funny", False, []), ("boring", False, []), ("scary", False, []),
            ("brave", False, []), ("mean", False, []), ("kind", False, []),
            ("easy", False, []), ("difficult", False, []), ("wrong", False, []),
            ("right", False, []), ("safe", False, []), ("dangerous", False, [])
        ],
        "sense": [
            ("see", True, []), ("hear", True, []), ("smell", False, []), 
            ("taste", False, []), ("touch", False, []), ("feel", True, [])
        ],
        "feeling": [
            ("excited", False, []), ("bored", False, []), ("worried", False, []), 
            ("surprised", False, []), ("proud", False, []), ("jealous", False, []),
            ("lonely", False, []), ("nervous", False, []), ("calm", False, []),
            ("confused", False, []), ("frustrated", False, []), ("silly", False, [])
        ],
        "thought": [
            ("smart", False, []), ("silly", False, []), ("crazy", False, []), 
            ("creative", False, []), ("wise", False, []), ("careful", False, [])
        ]
    },
    "social": {
        "phrases": [
            ("thank you", True, []), ("please", True, []), ("excuse me", False, []),
            ("i don't know", True, []), ("i'm sorry", True, []), ("no thank you", True, []),
            ("your turn", True, []), ("my turn", True, []), ("all done", True, []),
            ("help please", True, []), ("more please", True, []), ("yes please", True, [])
        ],
        "favourites": [
            ("like", True, []), ("love", False, []), ("hate", False, []), 
            ("favorite", False, []), ("best", False, []), ("worst", False, [])
        ],
        "greetings": [
            ("hello", True, []), ("bye bye", True, []), ("good morning", False, []),
            ("good night", False, ["action-sleep"]), ("hi", True, []), 
            ("welcome", False, []), ("see you later", False, []), ("how are you", False, [])
        ]
    },
    "things": {
        "people": [
            ("mom", True, []), ("dad", True, []), ("brother", False, []), 
            ("sister", False, []), ("baby", False, []), ("grandma", False, []), 
            ("grandpa", False, []), ("teacher", False, []), ("doctor", False, []), 
            ("nurse", False, []), ("friend", False, []), ("boy", False, []), 
            ("girl", False, []), ("man", False, []), ("woman", False, []), 
            ("dentist", False, []), ("police officer", False, []), 
            ("firefighter", False, []), ("student", False, []), ("family", False, [])
        ],
        "animals": [
            ("dog", False, []), ("cat", False, []), ("bird", False, []), 
            ("fish", False, []), ("horse", False, []), ("cow", False, []), 
            ("pig", False, []), ("sheep", False, []), ("chicken", False, []), 
            ("duck", False, []), ("lion", False, []), ("tiger", False, []), 
            ("bear", False, []), ("elephant", False, []), ("monkey", False, []), 
            ("giraffe", False, []), ("rabbit", False, []), ("mouse", False, []), 
            ("frog", False, []), ("snake", False, []), ("turtle", False, []),
            ("spider", False, []), ("bee", False, []), ("butterfly", False, []),
            ("shark", False, []), ("whale", False, []), ("dolphin", False, []),
            ("penguin", False, []), ("owl", False, []), ("fox", False, [])
        ],
        "nature": [
            ("tree", False, []), ("flower", False, []), ("grass", False, []), 
            ("sun", False, []), ("moon", False, []), ("star", False, []), 
            ("cloud", False, []), ("rain", False, []), ("snow", False, []), 
            ("wind", False, []), ("sky", False, []), ("water", True, []), 
            ("fire", False, []), ("rock", False, []), ("dirt", False, []), 
            ("leaf", False, []), ("river", False, []), ("ocean", False, []), 
            ("mountain", False, []), ("sand", False, [])
        ],
        "food": [
            ("apple", False, []), ("banana", False, []), ("orange", False, []), 
            ("grapes", False, []), ("strawberry", False, []), ("watermelon", False, []), 
            ("carrot", False, []), ("broccoli", False, []), ("potato", False, []), 
            ("tomato", False, []), ("corn", False, []), ("cucumber", False, []), 
            ("bread", False, []), ("rice", False, []), ("pasta", False, []), 
            ("pizza", False, []), ("burger", False, []), ("sandwich", False, []), 
            ("chicken", False, []), ("meat", False, []), ("fish", False, []), 
            ("egg", False, []), ("cheese", False, []), ("yogurt", False, []), 
            ("soup", False, []), ("salad", False, []), ("cereal", False, []), 
            ("pancakes", False, []), ("cookie", False, []), ("cake", False, []), 
            ("ice cream", False, []), ("candy", False, []), ("chocolate", False, []), 
            ("chips", False, []), ("popcorn", False, []), ("snack", True, [])
        ],
        "drink": [
            ("water", True, []), ("milk", False, []), ("juice", False, []), 
            ("tea", False, []), ("coffee", False, []), ("soda", False, []), 
            ("hot chocolate", False, []), ("smoothie", False, [])
        ],
        "body": [
            ("head", False, []), ("hair", False, []), ("face", False, []), 
            ("eye", False, []), ("ear", False, []), ("nose", False, []), 
            ("mouth", False, []), ("teeth", False, []), ("tongue", False, []), 
            ("neck", False, []), ("shoulder", False, []), ("arm", False, []), 
            ("elbow", False, []), ("hand", False, []), ("finger", False, []), 
            ("thumb", False, []), ("stomach", False, []), ("leg", False, []), 
            ("knee", False, []), ("foot", False, []), ("toe", False, []), 
            ("back", False, []), ("heart", False, []), ("blood", False, [])
        ],
        "clothes": [
            ("shirt", False, []), ("pants", False, []), ("shorts", False, []), 
            ("skirt", False, []), ("dress", False, []), ("jacket", False, []), 
            ("coat", False, []), ("sweater", False, []), ("pajamas", False, []), 
            ("underwear", False, []), ("socks", False, []), ("shoes", False, []), 
            ("boots", False, []), ("hat", False, []), ("cap", False, []), 
            ("gloves", False, []), ("scarf", False, []), ("swimsuit", False, []),
            ("belt", False, []), ("glasses", False, [])
        ],
        "home": [
            ("house", False, []), ("room", False, []), ("kitchen", False, []), 
            ("bathroom", False, []), ("bedroom", False, []), ("living room", False, []), 
            ("door", False, []), ("window", False, []), ("wall", False, []), 
            ("floor", False, []), ("ceiling", False, []), ("roof", False, []), 
            ("bed", False, []), ("pillow", False, []), ("blanket", False, []), 
            ("table", False, []), ("chair", False, []), ("couch", False, []), 
            ("desk", False, []), ("shelf", False, []), ("closet", False, []), 
            ("lamp", False, []), ("light", False, []), ("tv", False, []), 
            ("computer", False, []), ("phone", False, []), ("clock", False, []), 
            ("mirror", False, []), ("sink", False, []), ("toilet", False, []), 
            ("shower", False, []), ("bathtub", False, []), ("fridge", False, []), 
            ("oven", False, []), ("microwave", False, []), ("plate", False, []), 
            ("bowl", False, []), ("cup", False, []), ("glass", False, []), 
            ("fork", False, []), ("spoon", False, []), ("knife", False, []), 
            ("napkin", False, []), ("trash can", False, []), ("key", False, []), 
            ("toy", True, []), ("book", False, []), ("backpack", False, []), 
            ("towel", False, []), ("soap", False, []), ("toothbrush", False, []), 
            ("toothpaste", False, []), ("shampoo", False, []), ("brush", False, []), 
            ("comb", False, []), ("paper", False, []), ("pencil", False, []), 
            ("pen", False, []), ("crayons", False, []), ("scissors", False, [])
        ],
        "travel": [
            ("car", False, []), ("bus", False, []), ("train", False, []), 
            ("plane", False, []), ("bike", False, []), ("motorcycle", False, []), 
            ("truck", False, []), ("boat", False, []), ("ship", False, []), 
            ("subway", False, []), ("taxi", False, []), ("helicopter", False, []), 
            ("stroller", False, []), ("suitcase", False, []), ("ticket", False, []), 
            ("map", False, [])
        ],
        "places": [
            ("home", True, []), ("school", False, []), ("park", False, []), 
            ("store", False, []), ("shop", False, []), ("hospital", False, []), 
            ("clinic", False, []), ("library", False, []), ("restaurant", False, []), 
            ("beach", False, []), ("pool", False, []), ("playground", False, []), 
            ("zoo", False, []), ("farm", False, []), ("garden", False, []), 
            ("yard", False, []), ("street", False, []), ("road", False, []), 
            ("station", False, []), ("airport", False, []), ("bank", False, []), 
            ("office", False, []), ("theater", False, []), ("museum", False, [])
        ],
        "art": [
            ("picture", False, []), ("drawing", False, []), ("painting", False, []), 
            ("clay", False, []), ("markers", False, []), ("chalk", False, []), 
            ("stickers", False, []), ("stamp", False, [])
        ],
        "music": [
            ("music", False, []), ("song", False, []), ("radio", False, []), 
            ("piano", False, []), ("guitar", False, []), ("drums", False, []), 
            ("flute", False, []), ("bell", False, [])
        ],
        "games": [
            ("game", False, []), ("toy", False, []), ("ball", False, []), 
            ("blocks", False, []), ("puzzle", False, []), ("doll", False, []), 
            ("car toy", False, []), ("train toy", False, []), ("lego", False, []), 
            ("cards", False, []), ("dice", False, []), ("swing", False, []), 
            ("slide", False, []), ("sandbox", False, []), ("bubble", False, [])
        ],
        "occasions": [
            ("party", False, []), ("birthday", False, []), ("holiday", False, []), 
            ("christmas", False, []), ("halloween", False, []), ("wedding", False, []), 
            ("gift", False, []), ("cake", False, [])
        ]
    }
}

words_database = []
total_count = 0

# Flatten loop to transform sources into valid schemas
for main_type, sub_dict in vocabulary_source.items():
    for sub_type, word_list in sub_dict.items():
        for item in word_list:
            text_value = item[0]
            is_core = item[1]
            related = item[2]
            
            # Form clean consistent word IDs using prefix pattern
            # logic cleans compound words like 'ice cream' to 'ice-cream'
            clean_id_text = text_value.lower().replace(" ", "-")
            generated_word_id = f"{main_type}-{sub_type}-{clean_id_text}"
            
            # Process standardized image paths based on requested assets 
            # (supports stick drawings "simples" and real "photo")
            img_filename = f"{clean_id_text}.png"
            image_paths = [
                f"simple_aac_core/images/{main_type}/{sub_type}/simples/{img_filename}",
                f"simple_aac_core/images/{main_type}/{sub_type}/photo/{img_filename}"
            ]
            
            # Map simplified relative hooks back to proper unique keys
            mapped_related_ids = []
            for rel in related:
                if "-" in rel:
                    mapped_related_ids.append(rel)
                else:
                    mapped_related_ids.append(f"{main_type}-{sub_type}-{rel.lower().replace(' ', '-')}")

            card_record = {
                "wordId": generated_word_id,
                "text": text_value,
                "phoneticOverride": None,
                "type": main_type,
                "subType": sub_type,
                "imagePaths": image_paths,
                "isCoreVocabulary": is_core,
                "extraRelatedWordIds": mapped_related_ids,
                "aiSuggestedFollowUps": [],
                "createdDate": None # Handled explicitly by Firebase ServerTimestamp on write
            }
            
            words_database.append(card_record)
            total_count += 1

# Limit target exactly to top 500 records if definitions exceed threshold
final_output_data = words_database[:500]

with open("words.json", "w", encoding="utf-8") as f:
    json.dump(final_output_data, f, indent=2, ensure_ascii=False)

print(f"Success. Generated exactly {len(final_output_data)} flashcard entries inside 'words.json'.")