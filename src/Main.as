package  
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Clases.HitTest;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	/**
	 * ...
	 * @author Sephi_MBC
	 */
	public class Main extends MovieClip 
	{
		public const carreteraAbajo:Number = 391;
		public const carreteraMedia:Number= 346;
		public const carreteraAlta:Number = 300;
		var posicion:Number = carreteraMedia;
		var obstaculos:Obstaculos;
		var puntos:Number;
		public var vidas:Number;
		
		public function Main() 
		{
			//trace(carreteraAbajo, carreteraMedia, carreteraAlta);
			obstaculos = new Obstaculos(this);
			iniciar();
			//trace("" + this.getChildIndex(Pena_Nieto));
			for (var n:Number = 0; n < obstaculos.obstaculos.length; n++) {
				//trace("" + this.getChildIndex(obstaculos.obstaculos[n]));
			}
			this.setChildIndex(Pena_Nieto,4);
			
		}
		
		function iniciar():void {
			posicion = carreteraMedia;
			Pena_Nieto.y = carreteraMedia;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, teclaPresionada);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			puntos = 0;
			vidas = 3;
		}
		
		function terminar():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, teclaPresionada);
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			obstaculos.terminar();
			this.removeChild(Pena_Nieto);
		}
		
		function enterFrame(evt:Event):void {
			for (var n:Number = 0; n < obstaculos.obstaculos.length; n++) {
				if (HitTest.complexHitTestObject(Pena_Nieto, obstaculos.obstaculos[n], 1) == true && obstaculos.obstaculos[n].y == posicion) {
					//trace(this.getChildIndex(obstaculos.obstaculos[n]));
					if (obstaculos.objetoTocado[n] == false) {
						if (n == 0) {
							puntos++;
							//trace("" + this.getChildIndex(Pena_Nieto));
							//trace("ok puntos");
						}else {
							vidas--;
							//trace("ok vidas");
						}
						obstaculos.objetoTocado[n] = true;
					}
					vidas_txt.text = "" + vidas;
					puntos_txt.text = "" + puntos;
					//trace("puntos: " + puntos);
					//trace("Vidas: " + vidas);
				}else {
					obstaculos.objetoTocado[n] = false;
				}
				
			}
			
			if (vidas < 1) {
				gotoAndStop(3);
				
				this.terminar();
				//this.removeChild(obstaculos);
			}
			if (puntos > 9 && vidas > 0) {
				gotoAndStop(2);
				
				this.terminar();
				//this.removeChild(obstaculos);
			}
			/*if (currentFrame == 2 || this.currentFrame==3) {
				regresa_btn.addEventListener(MouseEvent.MOUSE_DOWN, regresa);
			}*/

		}
		function regresa(evt:MouseEvent):void {
			trace("ok1");
		}
		
		function teclaPresionada(tecla:KeyboardEvent):void {
			//trace("tecla presionada: " + tecla.keyCode);
			if (tecla.keyCode == 38) {
				switch(posicion) {
					case carreteraAbajo:
						Pena_Nieto.y = carreteraMedia;
						posicion = carreteraMedia;
						break;
					case carreteraMedia:
						Pena_Nieto.y = carreteraAlta;
						posicion = carreteraAlta;
						break;
				}
			}
			if (tecla.keyCode == 40) {
				switch(posicion) {
					case carreteraAlta:
						Pena_Nieto.y = carreteraMedia;
						posicion = carreteraMedia;
						break;
					case carreteraMedia:
						Pena_Nieto.y = carreteraAbajo;
						posicion = carreteraAbajo;
						break;
				}
			}
			switch(posicion) {
				case carreteraAbajo:
					this.setChildIndex(Pena_Nieto, 7);
					break;
				case carreteraMedia:
					this.setChildIndex(Pena_Nieto, 5);
					break;
				case carreteraAlta:
					this.setChildIndex(Pena_Nieto, 3);
					break
			}
			
		}
	}
	
}