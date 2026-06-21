extends Control

@export var liftCurve: Curve
@export var cardsOverlap: float = 0.05
@export var maxRotation: float = PI/9

var basePosition: Vector2
var mousePressed: bool

var activeCard: CardBody
var cards: Array[CardBody]

func updateCards():
	basePosition = get_viewport_rect().size / 2
	var cardsSize: int = cards.size()
	if cardsSize == 0:
		return
	for cardIndex: int in range(cardsSize):
		var card: CardBody = cards[cardIndex]
		var ratio: float = 0.5 if cardsSize == 1 else float(cardIndex) / float(cardsSize - 1)
		var centered: float = ratio * 2.0 - 1.0
		var lift: float = liftCurve.sample(ratio)
		var cardDimentions: Vector2 = card.sprite_2d.get_rect().size * card.sprite_2d.scale
		card.z_index = cardIndex
		card.global_position = basePosition + cardDimentions * Vector2(0.5, 0) + \
			Vector2(cardIndex * cardDimentions.x * cardsOverlap, -lift * 40.0) - \
			Vector2(cardDimentions.x + (cardsOverlap * cardDimentions.x * (cardsSize - 1)), 0) / 2
		card.rotation = centered * maxRotation
		card.sprite_2d.position = Vector2.UP.rotated(rotation) * cardDimentions.y * 0.2 if card == activeCard else card.collision_shape_2d.position 
		if card.rotation == 0:
			card.position.y += 10

func _process(_delta: float) -> void:
	var mousePosition: Vector2 = get_global_mouse_position()
	if cards.is_empty():
		return
	var minDistance: float = INF
	var minCard: CardBody = null
	for card in cards:
		if !card.isActive:
			continue
		var distance = mousePosition.distance_to(card.global_position)
		if minCard == null || distance < minDistance:
			minDistance = distance
			minCard = card
	activeCard = minCard
	updateCards()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click") && activeCard != null:
		remove_child(activeCard)
		activeCard.queue_free()

func _on_child_entered_tree(node: CardBody) -> void:
	await get_tree().root.ready
	cards.append(node)
	updateCards()

func _on_child_exiting_tree(node: CardBody) -> void:
	cards.erase(node)
	updateCards()
