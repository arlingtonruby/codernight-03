puzzlenode_11_rock_bottom
=========================

Puzzlenode problem #11, solved using Ruby

2 incomplete solutions (ps11_solution_hashes* and ps11_solution_arrays.rb) 
and 1 complete solution (ps11_solution_FINAL.rb).

######
## INCOMPLETE SOLUTIONS
######

For my first attempt, I branched one way for using hashes to represent columns and rows, and arrays for the other branch. I started with hashes, as I figured it would be more efficient if a large problem ("cave") was presented. As a result, I never made it to the arrays file (you'll see that it probably looks almost identical). I did write functions for mapping the input in row and column hashes, and ended up using those functions in my final solution.

I was going to solve the problem by writing a fill_down function, meaning for ever "step" the water took further into the cave, it would go down if possible, or to the right if not. If neither down or to the right were possible, the function would return. The second function was going to be a fill_up function, which would then find the height of the "cliff", or the pound sign that was blocking movement to the right, and fill rows going upwards.

As you can imagine, this wasn't the most efficient way to solve this, and I quickly decided to go a different route . . .

######
## FINAL SOLUTION
######

I ended up writing a while loop that used the "total water units" as a counter. I wrote several functions for the "actions" of the water: fill_space, touch_bottom, touch_right, and move_up. fill_space would convert the current position to "~", touch_bottom would see if the space below the current position was a " ", and if so would move to that space. touch_right was the same thing, but to the right. move_up would move up one row, identify the left-most index of "~", and set the current position as one space to the right of that index. 

Using control flow within the while loop, the loop would fill the current space, then touch_bottom. If not a " ", it would touch_right. If not a " ", it would move_up. This behavior continues until the water runs out, using the counter. I added a few little features at the end of the program for a little bit of fun UI.

Completed 6/13/14.
