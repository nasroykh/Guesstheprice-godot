extends Control

onready var PlayerInput = $VBoxContainer/PlayerInput
onready var PlayerDisplay =  $VBoxContainer/PlayerDisplay
onready var ReplayButton =  $VBoxContainer/HBoxContainer/Replay
onready var EnterButton =  $VBoxContainer/HBoxContainer/Enter
onready var PlayerAttempts = $VBoxContainer/Attempts

var enteredNumber
var generatedNumber
var attempts = 0
var maxAttempts = 20

func generate_number():
	randomize()
	return randi() % 10000 + 10

func _ready():
	PlayerInput.grab_focus()
	generatedNumber = generate_number()
	print(generatedNumber)

func _on_LineEdit_text_entered(new_text):
	enteredNumber = int(new_text)
	numCheck()
	PlayerInput.clear()

func _on_Enter_pressed():
	enteredNumber = int(PlayerInput.text)	
	numCheck()
	PlayerInput.clear()

func numCheck():
	attempts+=1
	if (enteredNumber < generatedNumber) :
		PlayerDisplay.text = "It's more !"
	elif (enteredNumber > generatedNumber) :
		PlayerDisplay.text = "It's less !"
	elif (enteredNumber == generatedNumber):
		PlayerDisplay.text = "You got it right buddy !"
		PlayerInput.queue_free()
		EnterButton.queue_free()
	if (attempts == maxAttempts) and (not enteredNumber == generatedNumber):
		PlayerDisplay.text = "Out of attempts, Retry !"
		PlayerInput.queue_free()
		EnterButton.queue_free()
	PlayerAttempts.text = "Attempts : " + str(attempts) + "/" + str(maxAttempts) 

func _on_Replay_pressed():
	var tree = get_tree()
	tree.reload_current_scene()
