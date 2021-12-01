layerLog = (
    (states: N1),
    (cxStates: N2),
    (selectStates: N1),
    (selectCxStates: N2),
    (time: N)
)

runLog = (
    (states: B1),
    (cxStates: B2),
    (selectStates: B3),
    (selectCxStates: B4),
    (runs: ILSL),
    (prev: ILS)
)


run = (
    (statusRun: working),
    (#states: 0),
    (#cxStates: 0),
    (proc: MI),
    (timeStates: nil),
    (timeCxStates: nil)
)

procLog = (
    (jobs: NS),
    (timeStart: 0),
    (statusRun: waiting),
    (current: empNode)
)