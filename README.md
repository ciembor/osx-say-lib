# osx-say-lib - macOS `say` library for text-to-speech functionality

## **Table of Contents**
1. [Overview](#overview)
2. [Installation](#installation)
3. [Classes and Methods](#classes-and-methods)
    - [Speaker](#speaker-class)
    - [Counter](#counter-class)
    - [Loop](#loop-class)
4. [Examples](#examples)
5. [System Requirements](#system-requirements)

---

## **Overview**
`osx-say-lib` is a Ruby library designed to automate repetitive tasks such as counting up, counting down, or executing loops with text-to-speech functionality. It provides utilities for speaking messages using macOS's `say` command and managing delays between operations.

---

## **Installation**
1. Add `osx-say-lib` to your project:
   ```ruby
   gem 'osx-say-lib', path: '/path/to/osx-say-lib'
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Require the library in your Ruby script:
   ```ruby
   require 'osx_say_lib'
   ```

---

## **Classes and Methods**

### **Speaker Class**
#### **Description**
`Speaker` manages text-to-speech functionality using the `say` command available on macOS.

#### **Public Methods**
1. **`initialize(voice: 'Karen')`**
   - Creates a new `Speaker` instance.
   - **Parameters:**
     - `voice` *(String)*: Optional. The voice to be used by the `say` command (default: `'Karen'`).

2. **`self.available?`**
   - Checks if the `say` command is available on the system.
   - **Returns:** `true` if available, `false` otherwise.

3. **`say(text, delay = 0)`**
   - Speaks the provided `text`.
   - **Parameters:**
     - `text` *(String)*: The text to speak.
     - `delay` *(Numeric)*: Optional. Time in seconds to wait after speaking (default: `0`).
   - **Raises:**
     - `ArgumentError`: If `delay` is not a number or is negative.

4. **`say_async(text, delay = 0)`**
   - Speaks the provided `text` in a separate thread.
   - **Parameters:**
     - `text` *(String)*: The text to speak.
     - `delay` *(Numeric)*: Optional. Time in seconds to wait after speaking (default: `0`).

---

### **Counter Class**
#### **Description**
`Counter` facilitates counting operations with optional text-to-speech integration.

#### **Public Methods**
1. **`initialize`**
   - Creates a new `Counter` instance.

2. **`countup(times:, delay: 1, modulo: nil, final: nil)`**
   - Counts up from `1` to `times` with optional conditions.
   - **Parameters:**
     - `times` *(Integer)*: The target count.
     - `delay` *(Numeric)*: Optional. Time in seconds to wait between iterations (default: `1`).
     - `modulo` *(Integer)*: Optional. Numbers are spoken only if divisible by `modulo`.
     - `final` *(Integer)*: Optional. Always speak the last `final` numbers.

3. **`countdown(times:, delay: 1, modulo: nil, final: nil)`**
   - Counts down from `times` to `1` with optional conditions.
   - **Parameters:** Same as `countup`.

---

### **Loop Class**
#### **Description**
`Loop` repeats a sequence of messages with customizable delays.

#### **Public Methods**
1. **`initialize`**
   - Creates a new `Loop` instance.

2. **`run(sentences:, inner_delay: 1, outer_delay: 0, times:)`**
   - Repeats the provided `sentences` for a specified number of iterations.
   - **Parameters:**
     - `sentences` *(Array<String>)*: The list of messages to speak.
     - `inner_delay` *(Numeric)*: Optional. Time in seconds to wait between sentences (default: `1`).
     - `outer_delay` *(Numeric)*: Optional. Time in seconds to wait between iterations (default: `0`).
     - `times` *(Integer)*: The number of times to repeat the sequence.
   - **Raises:**
     - `ArgumentError`: If `times` is not provided.

---

## **Examples**

### **Using Speaker**
```ruby
speaker = OsxSayLib::Speaker.new(voice: 'Samantha')
speaker.say("Hello, world!", 2)    # Speak text with a 2-second delay after speaking
speaker.say("Here we go!")         # Speak without delay
speaker.say_async("Async message") # Speak text asynchronously
```

### **Using Counter**
```ruby
counter = OsxSayLib::Counter.new
counter.countdown(times: 10) # Count down from 10 to 1
counter.countup(times: 60, modulo: 5) # Count up for one minute, say only every 5th number
counter.countdown(times: 5, delay: 0.5, modulo: 5, final: 10) # Count down from 5 with a 0.5-second delay, say only every 5th number, but each number at the end from 10 to 1
```

### **Using Loop**
```ruby
looper = OsxSayLib::Loop.new
looper.run(
  sentences: ["Push-up!", "Rest"],
  inner_delay: 2,
  outer_delay: 5,
  times: 10
) # Speak "Push-up!" and "Rest" with 2 seconds between them, repeat 10 times with a 5-second break between iterations
```

---

## **System Requirements**
- macOS with the `say` command available (default on macOS systems).
- Ruby 2.5 or newer.

---

## **Contributing**
Feel free to contribute by submitting issues or pull requests to improve the library!

---