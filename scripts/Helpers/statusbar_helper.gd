extends Node2D
#
@export_group("Size Options")
@export_subgroup("Inner Bar")
@export var currValue : int = 30
@export var maxValue : int = 100
@export_subgroup("Container Size")
@export var barHeight : int = 50
@export var barWidth : int = 100
#
@export_group("Options")
@export var showBorder : bool = false
@export var showColorByValue : bool = false
@export_subgroup("Text Options")
@export var showText : bool = false
@export var showTextOnBar : bool = false
@export var centerText : bool = false
@export var textColor : Color = Color.WHITE
@export_group("Initial Colors")
@export var containerColor : Color = Color.AQUA
@export var barColor : Color = Color.BLUE
@export var borderColor : Color = Color.BLACK
#
var stausBarContainer : Rect2i = Rect2i(10, 10, barWidth, barHeight)
var label = Label.new()

func _ready() -> void:
	add_child(label)
	
func _process(delta) : 
	#Update rectangles
	updateColorByValue(Color.RED, Color.YELLOW, Color.WEB_GREEN)
	displayTextValue(showTextOnBar,centerText)
	queue_redraw()	
	
func DrawBar() -> void:
	#Don't let current value get out of bounds
	if (currValue > maxValue):
		currValue = maxValue
	elif (currValue < 0) : 
		currValue = 0
	
	#Generate new rectagles before drawing with updated values
	stausBarContainer = Rect2i(10, 10, barWidth, barHeight)
	var barContainer : Rect2i = Rect2i(10, 10, currValue, barHeight)
	var borderRect : Rect2i = Rect2i(10, 10, barWidth, barHeight)
	
	#Draw the Rectangles	
	draw_rect(stausBarContainer, containerColor, true)
	draw_rect(barContainer, barColor, true)
	
	if (showBorder):
		draw_rect(stausBarContainer, borderColor, false)
func setBarColor(color:Color) -> void:
	barColor = color
func setBorderColor(color:Color) -> void:
	borderColor = color

func updateColorByValue(lowBar:Color, halfBar:Color, fullBar:Color) -> void:
	if(showColorByValue):
		var currentPercentage = maxValue / currValue 
		#print_debug("current percentage:" + var_to_str(currentPercentage))
		if(currentPercentage >= 3):
			setBarColor(lowBar)		
		elif(currentPercentage >= 2):
			setBarColor(halfBar)
		elif(currentPercentage <= 1):
			setBarColor(fullBar)	
	else:
		setBarColor(Color.GREEN)

func displayTextValue(showOnBar:bool= false,center:bool = false) -> void:
	if (showText):
		var textXPos = stausBarContainer.position.x
		var textYPos = stausBarContainer.position.y 
		#start at the current bar position, 
		##then add the width / 2 to start text in the center 
		###then /2 again to actually center the text.
		var centerXPos = (textXPos + (barWidth / 3))
		
		if(showTextOnBar):			
			textYPos = stausBarContainer.position.y 
		else: 
			textYPos = barHeight + 10 
			
		if(center):
			textXPos = centerXPos
		else:	
			textXPos = stausBarContainer.position.x	
	
		label.position = Vector2(textXPos, textYPos)
		label.text = var_to_str(currValue) + " / " + var_to_str(maxValue)
	else :
		label.text = ""
