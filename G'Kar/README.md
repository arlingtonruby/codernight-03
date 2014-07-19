I TDD’d it. I tried to focus on not over-testing (a weakness of mine).  Failed there a little bit on my FlowRule specs.  I could correct this by removing specs that weren’t immediately relevant to the TDD.  However, some of the specs provided desirable verification before the acceptance tests were passing.

Tried to focus most on ending up with a clean and simple design.  While the “flow stack" approach may not be the fastest (I’m fairly sure that the stack could be compacted somewhat), it seemed to elegantly solve the “how do I rewind back to some position where water can flow?” problem neatly.

In reviewing my history, I added my acceptance tests late.  I started with a simple high level test that I treated as an acceptance test for some time.  However, I should have begun with the Puzzle Node-provided tests for the ultimate arbiter of whether the problem was solved correctly.

