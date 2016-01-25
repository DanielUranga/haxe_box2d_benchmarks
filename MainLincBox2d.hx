package;

import box2d.collision.shapes.B2EdgeShape;
import box2d.collision.shapes.B2PolygonShape;
import box2d.common.math.B2Vec2;
import box2d.dynamics.B2Body;
import box2d.dynamics.B2World;
import haxe.Timer;

class MainLincBox2d {

	static var frames = 10;

	public static function main () {
		
		var gravity = B2Vec2.create(0.0, -10.0);
		var world = B2World.create(gravity);
		world.setAllowSleeping(false);

		var bd = B2BodyDef.create();
		var ground = world.createBody(bd.getPointer());

		var shape = B2EdgeShape.create();
		var v1 = B2Vec2.create(-40.0, 0.0);
		var v2 = B2Vec2.create(40.0, 0.0);
		shape.set(v1, v2);

		ground.createFixtureFromShape(shape.getB2ShapeReference(), 0.0);

		var shape = B2PolygonShape.create();
		shape.setAsBox(0.5, 0.5);
		var x = B2Vec2.create(-7.0, 0.75);
		var y = B2Vec2.create(0.0, 0.0);
		var deltaX = B2Vec2.create(0.5625, 1.0);
		var deltaY = B2Vec2.create(1.125, 0.0);
		var eCount = 30;
		for (i in 0...eCount) {
			y.assign(x);
			for (j in 0...eCount) {
				var bd = B2BodyDef.create();
				bd.type = B2BodyType.b2_dynamicBody();
				bd.position.assign(y);
				var body = world.createBody(bd.getPointer());
				body.createFixtureFromShape(shape.getB2ShapeReference(), 5.0);
				y.add(deltaY);
			}
			x.add(deltaX);
		}

		var start = Timer.stamp();
		for (i in 0...frames) {
			world.step(1.0/60.0, 3, 3);
		}
		var end = Timer.stamp();

		trace("Total time: " + (end-start));

	}

}
