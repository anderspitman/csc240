/* 
 * Anders Pitman - Program 1
 */

#include <iostream>

#include "printer.hpp"

Printer printer;

using namespace std;

class Entry {
    private:
        string heading;

    protected:
        void setHeading(string heading) {
            this->heading = heading;
        }

    public:
        string getHeading() {
            return heading;
        }

        virtual void print() {};

        static Entry* makeEntry(string heading, string paragraph);
        static Entry* makeEntry(string heading, string* list, int len);
};


class ParagraphEntry: public Entry {
    private:
        string paragraph;

    public:
        ParagraphEntry(string heading, string paragraph) {
            this->setHeading(heading);
            this->paragraph = paragraph;
        }
        void print() {
            int column = 0;
            cout << this->getHeading() << endl;

            cout << "  ";
            printer.printWrap(this->paragraph, 2);
            cout << endl;
        }
};


class ListEntry: public Entry {
    private:
        string* list;
        int len;

    public:
        ListEntry(string heading, string* list, int len) {
            this->setHeading(heading);
            this->list = list;
            this->len = len;
        }
        void print() {
            cout << this->getHeading() << endl;

            for (int i=0; i<len; i++) {
                cout << "  " << this->list[i] << endl;
            }
            cout << endl;
        }
};


Entry* Entry::makeEntry(string heading, string paragraph) {
    return new ParagraphEntry(heading, paragraph);
}

Entry* Entry::makeEntry(string heading, string* list, int len) {
    return new ListEntry(heading, list, len);
}


class EntryManager {
    private:
        Entry **entries;
        int index;

    public:
        EntryManager(int size) {
            entries = new Entry*[size];
            index = 0;
        }

        void addEntry(Entry *entry) {
            entries[index] = entry;
            index++;
        }

        void printAll() {
            for (int i=0; i<index; i++) {
                entries[i]->print();
            }
        }
};


int main() {

    EntryManager em(10);

    em.addEntry(Entry::makeEntry("Name:", "Anders Pitman"));

    const int LEN_COURSEWORK = 4;
    string coursework[LEN_COURSEWORK] = {
        "CSC110 (Zerange)",
        "CSC205 (Heil)",
        "Bioinformatics Algorithms 1 (Coursera MOOC)",
        "Functional Programming Prin. in Scala (Coursera MOOC)"
    };
    em.addEntry(Entry::makeEntry("Prior CS Coursework:", coursework,
                                 LEN_COURSEWORK));

    string prof = "6 years software engineering experience. 2 in avionics"
                  ", 3 in telecom, and 1 in bioinformatics";
    em.addEntry(Entry::makeEntry("Professional Background:", prof));

    string other_exp = "Sometimes do PC builds.";
    em.addEntry(Entry::makeEntry("Other computer experience:", other_exp));

    const int LEN_ENV = 5;
    string environment[LEN_ENV] = {"Linux", "VIM", "git", "Makefiles", "gcc"};
    em.addEntry(Entry::makeEntry("Programming Environment:", environment,
                                 LEN_ENV));

    const int LEN_LANGUAGES = 11;
    string languages[LEN_LANGUAGES] = {"C", "C++", "Python", "JavaScript",
                                       "Scala", "Rust", "Go", "HTML", "CSS",
                                       "Ada", "Scheme"};
    em.addEntry(Entry::makeEntry("Languages:", languages, LEN_LANGUAGES));

    string goals = "I want to fulfill this prereq and have fun learning! "
                   "I'm especially looking foward to digging into Lisp some"
                   "more.";
    em.addEntry(Entry::makeEntry("Personal Goals:", goals));

    em.addEntry(Entry::makeEntry("Concerns:", "Nada"));

    em.addEntry(Entry::makeEntry("Other courses:", "ECE102 and ECE103."));

    string fav_program = "At my last job I made a plotting framework"
                         "in C and Python that enabled us to visualize"
                         "wireless channels in real time. It was pretty cool.";
    em.addEntry(Entry::makeEntry("Favoriate Program Written:", fav_program));

    const int LEN_INTERESTS = 4;
    string interests[LEN_INTERESTS] = {"hiking", "reading", "fiddle",
                                       "guitar"};
    em.addEntry(Entry::makeEntry("Personal Interests:", interests,
                                 LEN_INTERESTS));

    em.printAll();

    return 0;
}
