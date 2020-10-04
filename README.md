# L+1 Layers Divide and Conquer Approach to Leads-To and Eventually Model Checking

The tool is developed in **Full Maude** supported by **Maude 2.7.1** version.

## How to use
We have 2 case studies **QLOCK** and **TAS** under the **specs** folder for demo.

The following shows how to interact with the tool to do model checking with our approach.

**Note that:** For **LeadsTo** property, you need to define **LeadsTo** and **Eventually** formula in the specfication. For **Eventually** property, you only need to define **Eventually** formula in the specfication.

**Step1:** Start up Maude and load your specfication.

in specs/qlock.maude

**Step2:** Load Full maude because we developed based on it.

in full-maude

**Step3:** Load our solver maude program.

in solver.maude

**Step4:** Check how many commands supported by the tool.

(solver-help)

Let us briefly explain one by one as follows:

1./ `(initialize[<module>,<initState>,<leadsToFormula>,<eventuallyFormula>,<elementSort>,<soupSort>])`

This command initializes some information from which the tool can know
and do model checking with your specfication.

`<module>` : module name

`<initState>` : initial state

`<leadsToFormula>` : your LeadsTo formula

`<eventuallyFormula>` : your Eventulally formula

`<elementSort>` : sort of your observable components

`<soupSort>` : sort of soup of observable components

For QLOCK example with **LeadsTo** property, the following is the correct format:

`(initialize[QLOCK-CHECK, init, lofree1, lofree2, OComp, Soup{OComp}])`

For **Eventually** property, you set the `<leadsToFormula>` to `null`. The following is the correct format:

`(initialize[QLOCK-CHECK, init, null, lofree2, OComp, Soup{OComp}])`

2./ `(layerCheck <NatList>)`

Given a list of natural number that is the list of each layer depth.

For example: `(layerCheck 2 2)`

3./ `(lastCheck)`

Checking at the last layer and returning a result.

For example: `(lastCheck)`

4./ `(check <NatList>)`

This command combines layerCheck and lastCheck into one command so that you do not need to do it separately.

For example: `(check 2 2)`

**Note that:** it is equivelant to call 2 commands `(layerCheck 2 2)` and `(lastCheck)` in order.

5./ `(clear)`

Restoring to the begining when you do an initialization.

For example: `(clear)`

6./ `(analyze)`

Showing current state with some information for debugging.

For example: `(analyze)`

7./ `(solver-help)`

Showing help.

For example: `(solver-help)`


**Full running for QLOCK:**

(initialize[QLOCK-CHECK, init5, lofree1, lofree2, OComp, Soup{OComp}])

(layerCheck 2 2)

(lastCheck)

(clear)

(check 2 2)

**Full running for TAS:**

(initialize[TAS-CHECK, init, lofree1, lofree2, OComp, Soup{OComp}])

(check 2 2)

(clear)

(layerCheck 2)

(layerCheck 2)

(lastCheck)

## Problem

We cannot print exactly the elapsed time of each command. However, we can two ways to mitigate the problem.

**1./ Using command line and output to a log file. (should use when experiment)**

Prepare a maude file and load all command being fed to Maude program. For example you can see `test.maude` file. Then using the following command:

`maude test.maude > out.log 2>&1`

When the program finishes, you can see the `out.log` file information, such as created date, modified data. From that you can calculate the elapsed time of the program.

**2./ Using another tool called `druss`, however this tool make the program slower (should use when debugging)**

`dtruss -a -t write -p <PID>`

In `RELATIVE` column, we get the value of a line which is executing your command and the value of the succeeding line.

That is relative timestamps in microsecond. The latter value substracts the former value and then dividing to 10^6.

You can get the elapsed time of your command in second.

**Note that:** you need to enable **dtrace** beforehand as following with Mac OS

```
Reboot the mac

Hold ⌘R during reboot

From the Utilities menu, run Terminal

Enter the following command

csrutil enable --without dtrace
```
