# L+1 Layers Divide and Conquer Approach to Leads-To, Eventually and Conditional Stable Model Checking

The tool has been developed in **Full Maude** powered by **Maude 3.1** version.

We support two versions of the tool: sequential and parallel versions.

## 1. How to use the sequential version
We have 2 case studies **QLOCK** and **TAS** under the **specs** folder for demo.

The following shows how to interact with the tool to do model checking with our approach.

**Step1:** Start up Maude and load your specfication.

in specs/qlock.maude

**Step2:** Load Full maude because we developed based on it.

in full-maude

**Step3:** Load our solver maude program.

in solver.maude

**Step4:** Check how many commands supported by the tool.

(solver-help)

Let us briefly explain one by one as follows:

1./ `(initialize[<module>,<initState>,<formula>,<elementSort>,<soupSort>])`

This command initializes some information from which the tool can know
and do model checking with your specfication.

`<module>` : module name

`<initState>` : initial state

`<formula>` : your formula such as leadsTo, eventually and conditional stable formulas

`<elementSort>` : sort of your observable components

`<soupSort>` : sort of soup of observable components

For QLOCK example with **LeadsTo** property, the following is the correct format:

`(initialize[QLOCK-CHECK, init, lofree, OComp, Soup{OComp}])`

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

(initialize[QLOCK-CHECK, init5, lofree, OComp, Soup{OComp}])

(layerCheck 2 2)

(lastCheck)

(clear)

(check 2 2)

**Full running for TAS:**

(initialize[TAS-CHECK, init, lofree, OComp, Soup{OComp}])

(check 2 2)

(clear)

(layerCheck 2)

(layerCheck 2)

(lastCheck)

*__How to measure model checking time__*

You can measure how much time it taken by running the `test-command.sh` file.

`./test-command`

## 2. How to use the parallel version (with socket implementation)

We develop a parallel version of the tool based on a master-worker model, where a master and workers communicate to each other by using sockets powered by Maude.

**Notice:** you can decide to run the parallel version in two modes: all layers and sole final layer parallelized.

In addition, the tool also can be deployed in a distributed environment as well as on a share-memory machine.

**Master**

Master configuration resides in the `solver-master.maude` file. For example, as follows:

```
< o : Database |
                db : initialDatabase,
                input : nilTermList, output : nil,
                db-ext : emptyDatabaseExt,
                server : aServer,
                cache : aCache,
                status : idle,
                isAll : true,
                default : 'CONVERSION >
                < aCache : Cache | CxState : empty, AllState : empty, server : aServer, app : o, logger : empty >
                < aServer : Server | app : o, cache : aCache >
                CreateServerTcpSocket(socketManager, aServer, 8811, 10)
                --- initialize(o, "initialize[QLOCK-CHECK, init10, lofree, OComp, Soup{OComp}]")
                --- initialize(o, "initialize[QLOCK-CHECK, init10, cstable, OComp, Soup{OComp}]")
                initialize(o, "initialize[QLOCK-CHECK, init10, halt, OComp, Soup{OComp}]")
                depthInfo(o, "depthInfo 2 2") .
```

Some parameters need to take into account such as:

`isAll` : choose one of the two modes described above. `true` value is for the former and `false` value otherwise.

`8811` and `10` : the port used for socket server and the maximum number of acceptable workers.

`initialize` and `depthInfo` : similar to the sequential version. We have one line commented with the `initialize` command that specifies for **eventually** model checking.

**Workers**

Each worker configuration resides in the `solver-worker.maude` file. For example, as follows:

```
< o : Database |
                db : initialDatabase,
                input : nilTermList, output : nil,
                db-ext : emptyDatabaseExt,
                client : aClient,
                cache : aCache,
                status : idle,
                batchSize : 1,
                logger : empty,
                default : 'CONVERSION >
                < aCache : Cache | CxState : empty, AllState : empty, server : aClient, app : o >
                < aClient : Client | app : o, cache : aCache >
                CreateClientTcpSocket(socketManager, aClient, "localhost", 8811)
                --- initialize(o, "initialize[QLOCK-CHECK, init10, lofree, OComp, Soup{OComp}]")
                --- initialize(o, "initialize[QLOCK-CHECK, init10, cstable, OComp, Soup{OComp}]")
                initialize(o, "initialize[QLOCK-CHECK, init10, halt, OComp, Soup{OComp}]")
                depthInfo(o, "depthInfo 3") .
```

`batchSize` : the number of accumulated jobs before sending them to the master.

You can use as many workers as possible provided that each worker runs independently on different machines or processes and not exceeding the maximum number of acceptable workers.