import csv
import json

words = {}
fp = "assets/data/words.json"

with open('toki_pona_dict.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:

        w = row['word']

        definition = {
            'pos': row['pos'],
            'def': row['definition'],
            'eg': row['example']}

        if not words.get(w):
            words[w] = {
                "word": w,
                "definitions": [definition]}
        else:
            words[w]['definitions'].append(definition)

wordsList = list(words.values())
with open(fp, 'w') as f:
    json.dump(wordsList, f)
