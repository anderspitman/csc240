#include <iostream>

using namespace std;

class Printer {
    private:
        static const int MAX_LINE_LEN = 80;
        int charsInCurrentLine;
        int indent;

        string *splitString(string text) {
            int numWords = countWords(text);
            string *words = new string[numWords];

            int startCurWord = 0;
            int wordIdx = 0;
            int len = text.length();
            for (int i=0; i<len+1; i++) {
                if (text[i] == ' ' || i == len) {
                    int lenWord = i - startCurWord;
                    string word = string(lenWord, 0);
                    int j;
                    for (j=0; j<lenWord; j++) {
                        word[j] = text[i - (lenWord - j)];
                    }
                    startCurWord = i+1;
                    words[wordIdx] = word;
                    wordIdx++;
                }
            }

            return words;
        }

        int countWords(string text) {
            int count = 0;
            for (int i=0; i<text.length(); i++) {
                if (text[i] == ' ') {
                    count++;
                }
            }
            return count + 1;
        }

        void printWord(string word) {
            if (charsInCurrentLine + word.length() > MAX_LINE_LEN - indent) {
                feedLine();
            }
            for (int i=0; i<word.length(); i++) {
                printChar(word[i]);
            }
            printChar(' ');
        }

        void printChar(char character) {
            if (charsInCurrentLine + 1 > MAX_LINE_LEN - indent) {
                feedLine();
            }
            cout << character;
            charsInCurrentLine++;
        }

        void feedLine() {
            cout << endl;
            charsInCurrentLine = 0;
            if (indent > 0) {
                for (int i=0; i<indent; i++) {
                    cout << ' ';
                }
            }
        }

    public:

        Printer() {
            charsInCurrentLine = 0;
            indent = 0;
        }

        void printWrap(string text, int indent=0) {
            this->indent = indent;
            string *words = splitString(text);

            for (int i=0; i<countWords(text); i++) {
                printWord(words[i]);
            }

            feedLine();
        }
};

