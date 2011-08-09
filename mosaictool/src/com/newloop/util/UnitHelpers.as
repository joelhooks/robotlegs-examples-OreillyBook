package com.newloop.util {

    import fl.controls.BaseButton;
    import fl.controls.ComboBox;
    import fl.controls.List;
    import fl.controls.listClasses.CellRenderer;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class UnitHelpers {

		public function UnitHelpers() {
		}


		public static function clickItemNumberInComboBox(comboBox:ComboBox, itemNumber:uint):void
		{
			var baseButton:BaseButton = comboBox.getChildAt(0) as BaseButton;
			baseButton.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));

			var list:List = baseButton.stage.getChildAt(baseButton.stage.numChildren-1) as List;
			clickItemNumberInList(list, itemNumber);
		}

		public static function clickItemNumberInList(list:List, itemNumber:uint):void
		{
		    var cellRenderer:CellRenderer = getCellRendererFromList(list, itemNumber);
			cellRenderer.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}

		public static function doubleClickItemNumberInList(list:List, itemNumber:uint):void
		{
		    var cellRenderer:CellRenderer = getCellRendererFromList(list, itemNumber);
			cellRenderer.dispatchEvent(new MouseEvent(MouseEvent.DOUBLE_CLICK));
		}

		protected static function getCellRendererFromList(list:List, itemNumber:uint):CellRenderer
		{
			var outerSprite:Sprite = list.getChildAt(3) as Sprite;
			var innerSprite:Sprite = outerSprite.getChildAt(0) as Sprite;
			var cellRenderer:CellRenderer = innerSprite.getChildAt(itemNumber) as CellRenderer;
			return cellRenderer;
		}


		public static function checkContainsInstanceOf(haystack:DisplayObjectContainer, needleClass:Class, recursionLevel:uint = 0):Boolean
		{
			var iLength:uint = haystack.numChildren;
			for (var i:int = 0; i < iLength; i++)
			{
				var nextChild:DisplayObject = haystack.getChildAt(i);
				if(nextChild is needleClass)
				{
					return true;
				}
				if(recursionLevel>0)
				{
					if(nextChild is DisplayObjectContainer)
					{
						if(checkContainsInstanceOf(nextChild as DisplayObjectContainer, needleClass, recursionLevel-1))
						{
							return true;
						}
					}
				}
			}

			return false;
		}

		public static function countInstancesOf(haystack:DisplayObjectContainer, needleClass:Class, recursionLevel:uint = 0):uint
		{
			var foundCount:uint = 0;

			var iLength:uint = haystack.numChildren;
			for (var i:int = 0; i < iLength; i++)
			{
				var nextChild:DisplayObject = haystack.getChildAt(i);
				if(nextChild is needleClass)
				{
					foundCount ++;
				}
				else if(recursionLevel>0)
				{
					if(nextChild is DisplayObjectContainer)
					{
						foundCount += countInstancesOf(nextChild as DisplayObjectContainer, needleClass, recursionLevel-1);
					}
				}
			}

			return foundCount;
		}

		public static function clickItem(item:InteractiveObject):void
		{
			item.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}

		public static function rollOverItem(item:InteractiveObject):void
		{
			item.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
		}

		public static function rollOutItem(item:InteractiveObject):void
		{
			item.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
		}

		public static function getBackground(width:Number = 800, height:Number = 600, color:uint = 0xFFFFFF):Sprite
		{
		   	var rectangle:Sprite = new Sprite();
			rectangle.graphics.beginFill(color, 1);
			rectangle.graphics.drawRect(0,0,width, height);
			rectangle.graphics.endFill();

			return rectangle;
		}

		public static function findInstanceOf(haystack:DisplayObjectContainer, needleClass:Class, recursionLevel:uint = 0):*
		{
			var iLength:uint = haystack.numChildren;

			for (var i:int = 0; i < iLength; i++)
			{
				var nextChild:DisplayObject = haystack.getChildAt(i);
				if(nextChild is needleClass)
				{
					return nextChild;
				}
				if(recursionLevel>0)
				{
					if(nextChild is DisplayObjectContainer && DisplayObjectContainer(nextChild) && DisplayObjectContainer(nextChild).numChildren > 0)
					{
						var deeperSearchResult:* = findInstanceOf(DisplayObjectContainer(nextChild), needleClass, recursionLevel-1);
						if(deeperSearchResult!=null)
						{
							return deeperSearchResult;
						}
					}
				}
			}

			return null;
		}

		public static function findAllInstancesOf(haystack:DisplayObjectContainer, needleClass:Class, recursionLevel:uint = 0):Array
		{
			var returnArray:Array = [];

			var iLength:uint = haystack.numChildren;

			for (var i:int = 0; i < iLength; i++)
			{
				var nextChild:DisplayObject = haystack.getChildAt(i);
				if(nextChild is needleClass)
				{
					returnArray.push(nextChild);
				}
				else if(recursionLevel>0)
				{
					if(nextChild is DisplayObjectContainer && DisplayObjectContainer(nextChild) && DisplayObjectContainer(nextChild).numChildren > 0)
					{
						var deeperSearchResult:* = findAllInstancesOf(DisplayObjectContainer(nextChild), needleClass, recursionLevel-1);
						for each (var item:Object in deeperSearchResult)
						{
							returnArray.push(item);
						}
					}
				}
			}

			return returnArray;
		}

		public static function findNamedInstanceOf(haystack:DisplayObjectContainer, needleClass:Class, needleName:String, recursionLevel:uint = 0):*
		{
			var iLength:uint = haystack.numChildren;
			for (var i:int = 0; i < iLength; i++)
			{
				var nextChild:DisplayObject = haystack.getChildAt(i);
				if((nextChild is needleClass) && (nextChild.name == needleName))
				{
					return nextChild;
				}
				if(recursionLevel>0)
				{
					if(nextChild is DisplayObjectContainer)
					{
						var deeperSearchResult:* = findNamedInstanceOf(nextChild as DisplayObjectContainer, needleClass, needleName, recursionLevel-1);
						if(deeperSearchResult!=null)
						{
							return deeperSearchResult;
						}
					}
				}
			}

			return null;
		}

		public static function getColorTransformOf(item:DisplayObject):uint
		{
			return item.transform.colorTransform.color;
		}

		public static function getTextInInstanceOf(haystack:DisplayObjectContainer, needleClass:Class, recursionLevel:uint = 0):String
		{
			var component:* = findInstanceOf(haystack, needleClass, recursionLevel);
			return component.text;
		}
	}
}