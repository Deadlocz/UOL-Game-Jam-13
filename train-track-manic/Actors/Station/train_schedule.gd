class_name TrainSchedule
extends Resource


## Type of train to spawn
@export var train_type: TrainType = TrainType.Normal
## Delay in seconds to spawn this train
@export var start_delay: float = 0.0
## Target station this train will try to get to
@export var target: String


enum TrainType {
	Slow,
	Normal,
	Fast,
}
