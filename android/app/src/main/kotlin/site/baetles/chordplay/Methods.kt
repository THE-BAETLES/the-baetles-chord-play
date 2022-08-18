package site.baetles.chordplay

enum class Methods {
    START_PITCHTRACKING {
        override fun toString(): String {
            return "startDetectingChord";
        }
    },

    STOP_PITCHTRACKING {
        override fun toString(): String {
            return "stopDetectingChord";
        }
    }
}