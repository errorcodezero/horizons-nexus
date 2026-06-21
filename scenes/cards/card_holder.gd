extends Control

@export var spacingCurve: Curve
@export var liftCurve: Curve
@export var cardsOverlap: float = 0.2

var basePosition = position
var mousePressed: bool
var mousePosition: Vector2

var cards: Array[CardBody]

func updateCards():
	var cardsSize: int = cards.size()
	if cardsSize == 0:
		return
	for cardIndex: int in range(cardsSize):
		var card: CardBody = cards[cardIndex]
		card.z_index = cardIndex
		card.position = basePosition + Vector2(cardIndex * card.size.x * card.scale.x * cardsOverlap, 0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click"):
		mousePressed = true
	if event.is_action_released("Left Click"):
		mousePressed = false

func _process(_delta: float) -> void:
	if mousePressed:
		mousePosition = get_global_mouse_position()

func _on_child_entered_tree(node: CardBody) -> void:
	cards.append(node)
	updateCards()

func _on_child_exiting_tree(node: CardBody) -> void:
	cards.erase(node)
	updateCards()
