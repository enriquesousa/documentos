# Path Relativo
Cursos/Victor Arana Flores/Ecommerce/Ecommerce.md

# Crea un Ecommerce con Laravel, Livewire, Tailwind y Alpine
Victor Arana Flores
@victoraranaflores
# Sección 1: Introducción
# 01. Programas necesarios
- https://github.com/coders-free/ecommerce
# 02. Instalación
En htdocs
- laravel new ecommerce --jet
- npm install && npm run dev
# 03. Extensiones VSC
# Sección 2: Diseño de la base de datos
# 04. Maquinación de la bbdd
# 05. Maquinación de la bbdd 2
# 06. Modelo físico
0:40
- php artisan make:model Category -ms

3:20
- php artisan make:model Subcategory -ms

10:16
- php artisan make:model Brand -mfs

12:50 - Tabla Intermedia
- php artisan make:migration create_brand_category_table

6:40
- php artisan make:model Product -mfs

14:04
- php artisan make:model Color -ms

15:00 - Tabla Intermedia
- php artisan make:migration create_color_product_table

17:40
- php artisan make:model Size -mf

19:18 - Tabla Intermedia
- php artisan make:migration create_color_size_table

22:30
- php artisan migrate
# 07. Generar relaciones Eloquent
Generar las relaciones a nivel de Eloquent.

1. Una Categoría puede tener varias subcategories y entre categories y brands hay una relación de muchos a muchos.

- app/Models/Category.php:
```php
class Category extends Model
{
    use HasFactory;
    protected $fillable = ['name','slug','image','icon'];

    // relación uno a muchos
    public function subcategories(){
        return $this->hasMany(Subcategory::class);
    }

    // relación muchos a muchos
    public function brands(){
        return $this->belongsToMany(Brand::class);
    }

    // relación a products a través de Subcategory 
    public function products(){
        return $this->hasManyThrough(Product::class, Subcategory::class);
    }
}
```

2. Ahora en 
- app/Models/Subcategory.php
```php
class Subcategory extends Model
{
    use HasFactory;

    // la propiedad $guarded hace el efecto contrario a $fillable
    protected $guarded = ['id', 'created_at', 'updated_at'];

    // relación uno a muchos
    public function products(){
        return $this->hasMany(Product::class);
    }

    // relación uno a muchos inversa, le llamamos en singular porque al llamarla solo tendrá una sola categoría
    public function category(){
        return $this->belongsTo(Category::class);
    }
}
```

7:30
Relación entres products y categories a traves de subcategories
3. Para 
- app/Models/Product.php
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    // la propiedad $guarded hace el efecto contrario a $fillable
    // que campos no quiero que asigne a la asignaciones masiva
    protected $guarded = ['id', 'created_at', 'updated_at'];

    // relación uno a muchos products y sizes
    public function sizes(){
        return $this->hasMany(Size::class);
    }

    // relación uno a muchos inversa
    public function brand(){
        return $this->belongsTo(Brand::class);
    }

    // relación uno a muchos inversa
    public function subcategory(){
        return $this->belongsTo(Subcategory::class);
    }

    // relación muchos a muchos products con colors
    public function colors(){
        return $this->belongsToMany(Color::class);
    }

    // relación uno a muchos polimórficas
    public function images(){
        return $this->morphMany(Image::class, "imageable");
    }

}
```

Relación entre size y colors
- app/Models/Size.php:
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Size extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'product_id'];

    // relación uno a muchos inversa entre sizes y colors 
    public function product(){
        return $this->belongsTo(Product::class);
    }

    // relación muchos a muchos sizes con colors
    public function colors(){
        return $this->belongsToMany(Color::class);
    }

}
```

- app/Models/Color.php:
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Color extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    // relación muchos a muchos colors con products
    public function products(){
        return $this->belongsToMany(Product::class);
    }

    // relación muchos a muchos colors con sizes
    public function sizes(){
        return $this->belongsToMany(Size::class);
    }

}
```

Asignación masiva en
- app/Models/Brand.php
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    use HasFactory;

    protected $fillable = ['name'];
    
}
```

Crear muevo modelo Image
- php artisan make:model Image -mf

- app/Models/Image.php
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;

    protected $fillable = ['url', 'imageable_id', 'imageable_type'];

    public function imageable(){
        return $this->morphTo();
    }
}
```

16.50
Realizar una relación uno a muchos polimórficas entre products y images
- app/Models/Image.php
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;

    protected $fillable = ['url', 'imageable_id', 'imageable_type'];

    public function imageable(){
        return $this->morphTo();
    }
}
```

- database/migrations/2022_03_01_042957_create_images_table.php
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('images', function (Blueprint $table) {
            $table->id();

            $table->string('url');

            $table->unsignedBigInteger('imageable_id');
            $table->string('imageable_type');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('images');
    }
};
```

No olvidar agregar la relación polimórficas al modelo Product
- app/Models/Product.php
```php
class Product extends Model
{
    use HasFactory;

    ...

    // relación uno a muchos polimórficas
    public function images(){
        return $this->morphMany(Image::class, "imageable");
    }

}
```
Listo!
# Sección 3: Insertar registros de prueba a la bbdd
# 08. Insertar registros en la tabla categories
Crear el seeder para users
- php artisan make:seeder UserSeeder

En database/seeders/UserSeeder.php:
```php
public function run()
{
    User::create([
        'name' => 'Enrique Sousa',
        'email' => 'enrique.sousa@gmail.com',
        'password' => bcrypt('sousa1234'),
    ]);
}
```

En database/seeders/DatabaseSeeder.php:
```php
public function run()
{
    // \App\Models\User::factory(10)->create();
    $this->call(UserSeeder::class);
}
```

14:20
Agregar registros en categorías
En database/seeders/CategorySeeder.php:
```php
<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $categories = [
            [
                'name' => 'Celulares y tablets',
                'slug' => Str::slug('Celulares y tablets'),
                'icon' => '<i class="fa-thin fa-mobile-screen-button"></i>'
            ],
            [
                'name' => 'TV, audio y video',
                'slug' => Str::slug('TV, audio y video'),
                'icon' => '<i class="fa-thin fa-tv"></i>'
            ],
            [
                'name' => 'Consola y video juegos',
                'slug' => Str::slug('Consola y video juegos'),
                'icon' => '<i class="fa-thin fa-gamepad-modern"></i>'
            ],
            [
                'name' => 'Computación',
                'slug' => Str::slug('Computación'),
                'icon' => '<i class="fa-thin fa-computer"></i>'
            ],
            [
                'name' => 'Moda',
                'slug' => Str::slug('Moda'),
                'icon' => '<i class="fa-thin fa-shirt"></i>'
            ],
        ];

        foreach ($categories as $category) {
            Category::factory(1)->create($category);
        }

    }
}
```

Crear un CategoryFactory
- php artisan make:factory CategoryFactory

Cambiar de local a public en
config/filesystems.php:
```php
'default' => env('FILESYSTEM_DISK', 'public'),
```

En database/factories/CategoryFactory.php:
```php
<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Category>
 */
class CategoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'image' => 'products/' . $this->faker->image('public/storage/products', 640, 480, null, false), // con false me regresa solo: imagen.jpg
        ];
    }
}
```

En database/seeders/DatabaseSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Storage;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Storage::deleteDirectory('public/products'); // borrar la carpeta por si ya existía
        // Storage::makeDirectory('products');
        // este es el que me funciona a mi
        Storage::makeDirectory('public/products');
        $this->call(UserSeeder::class);
        $this->call(CategorySeeder::class);
    }
}
```

Correr las migraciones para probar:
- php artisan migrate:fresh --seed
# 09. Insertar registros en la tabla subcategories
En database/seeders/SubcategorySeeder.php:
```php
<?php

namespace Database\Seeders;

use App\Models\Subcategory;
use Illuminate\Support\Str;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class SubcategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $subcategories = [
            
            // Celulares y tablets
            [
                'category_id' => 1,
                'name' => 'Celulares y smartphones',
                'slug' => Str::slug('Celulares y smartphones'),
                'color' => true,
            ],
            [
                'category_id' => 1,
                'name' => 'Accesorios para celulares',
                'slug' => Str::slug('Accesorios para celulares'),
            ],
            [
                'category_id' => 1,
                'name' => 'Smartwatches',
                'slug' => Str::slug('Smartwatches'),
            ],

            // TV, audio y video
            [
                'category_id' => 2,
                'name' => 'TV y audio',
                'slug' => Str::slug('TV y audio'),
            ],
            [
                'category_id' => 2,
                'name' => 'Audios',
                'slug' => Str::slug('Audios'),
            ],
            [
                'category_id' => 2,
                'name' => 'Audio para autos',
                'slug' => Str::slug('Audio para autos'),
            ],

            // Consola y video juegos
            [
                'category_id' => 3,
                'name' => 'Xbox',
                'slug' => Str::slug('Xbox'),
            ],
            [
                'category_id' => 3,
                'name' => 'Play station',
                'slug' => Str::slug('Play station'),
            ],
            [
                'category_id' => 3,
                'name' => 'Videojuegos para PC',
                'slug' => Str::slug('Videojuegos para PC'),
            ],
            [
                'category_id' => 3,
                'name' => 'Nintendo',
                'slug' => Str::slug('Nintendo'),
            ],

            // Computación
            [
                'category_id' => 4,
                'name' => 'Portátiles',
                'slug' => Str::slug('Portátiles'),
            ],
            [
                'category_id' => 4,
                'name' => 'PC escritorio',
                'slug' => Str::slug('PC escritorio'),
            ],
            [
                'category_id' => 4,
                'name' => 'Almacenamiento',
                'slug' => Str::slug('Almacenamiento'),
            ],
            [
                'category_id' => 4,
                'name' => 'Accesorios computadoras',
                'slug' => Str::slug('Accesorios computadoras'),
            ],

            // Moda
            [
                'category_id' => 5,
                'name' => 'Mujeres',
                'slug' => Str::slug('Mujeres'),
            ],
            [
                'category_id' => 5,
                'name' => 'Hombres',
                'slug' => Str::slug('Hombres'),
            ],
            [
                'category_id' => 5,
                'name' => 'Lentes',
                'slug' => Str::slug('Lentes'),
            ],
            [
                'category_id' => 5,
                'name' => 'Relojes',
                'slug' => Str::slug('Relojes'),
            ],

        ];

        foreach ($subcategories as $subcategory) {
            Subcategory::factory(1)->create($subcategory);
        }
    }
}
```
Crear el factory
- php artisan make:factory SubcategoryFactory

Corregir la carpeta de database/factories/CategoryFactory.php:
```php
<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Category>
 */
class CategoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'image' => 'categories/' . $this->faker->image('public/storage/categories', 640, 480, null, false), // con false me regresa solo: imagen.jpg
        ];
    }
}
```

En database/seeders/DatabaseSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Storage;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Storage::deleteDirectory('public/categories'); 
        Storage::deleteDirectory('public/subcategories');

        Storage::makeDirectory('public/categories'); 
        Storage::makeDirectory('public/subcategories');

        $this->call(UserSeeder::class);
        $this->call(CategorySeeder::class);
        $this->call(SubcategorySeeder::class);

    }
}
```

Correr las migraciones:
- php artisan migrate:fresh --seed
Listo!
Ya funciono hasta aquí.
# 10. Insertar registros en la tabla brands
Utilizar este factory database/factories/BrandFactory.php para introducir registros de las marcas.
```php
<?php

namespace Database\Factories;

use App\Models\Brand;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Brand>
 */
class BrandFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'name' => $this->faker->word(),
        ];
    }
}
```

Agregar relación de brands con categorías, y de una vez la relación entre brands y products.
app/Models/Brand.php:
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    // Relación uno a muchos
    public function products(){
        return $this->hasMany(Product::class);
    }

    // Relación muchos a muchos
    public function categories(){
        return $this->belongsToMany(Category::class);
    }

}
```

En database/seeders/CategorySeeder.php:
```php
<?php

namespace Database\Seeders;

use App\Models\Brand;
use App\Models\Category;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $categories = [
            [
                'name' => 'Celulares y tablets',
                'slug' => Str::slug('Celulares y tablets'),
                'icon' => '<i class="fa-thin fa-mobile-screen-button"></i>'
            ],
            [
                'name' => 'TV, audio y video',
                'slug' => Str::slug('TV, audio y video'),
                'icon' => '<i class="fa-thin fa-tv"></i>'
            ],
            [
                'name' => 'Consola y video juegos',
                'slug' => Str::slug('Consola y video juegos'),
                'icon' => '<i class="fa-thin fa-gamepad-modern"></i>'
            ],
            [
                'name' => 'Computación',
                'slug' => Str::slug('Computación'),
                'icon' => '<i class="fa-thin fa-computer"></i>'
            ],
            [
                'name' => 'Moda',
                'slug' => Str::slug('Moda'),
                'icon' => '<i class="fa-thin fa-shirt"></i>'
            ],
        ];

        foreach ($categories as $category) {
            $category = Category::factory(1)->create($category)->first();

            // cada categoría que vamos a crear tendrá 4 marcas distintas
            $brands = Brand::factory(4)->create();
            foreach ($brands as $brand) {
                $brand->categories()->attach($category->id);
            }

        }

    }
}
```

Hacer la prueba con:
- php artisan migrate:fresh --seed
Listo!
Cada categoría ya tiene 4 marcas!
# 11. Insertar registros en la tabla products
Agregar nuevo campo 'status' a la tabla products.
vamos almacenar dos números:
1 - el producto esta en proceso
2 - el producto ya esta publicado
En database/migrations/2022_03_01_024453_create_products_table.php:
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

use App\Models\Product; //para hacer referencia a las constantes BORRADOR y PUBLICADO

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();

            $table->string('name');
			$table->string('slug');
			$table->text('description');
			$table->float('price');

			$table->unsignedBigInteger('subcategory_id');
            $table->foreign('subcategory_id')->references('id')->on('subcategories');
            
            $table->unsignedBigInteger('brand_id');
            $table->foreign('brand_id')->references('id')->on('brands');
            
            $table->integer('quantity')->nullable();

            $table->enum('status', [Product::BORRADOR, Product::PUBLICADO])->default(Product::BORRADOR);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('products');
    }
};
```
Nota: como importamos use App\Models\Product; //para hacer referencia a las constantes BORRADOR y PUBLICADO
en app/Models/Product.php:
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    const BORRADOR = 1;
    const PUBLICADO = 2;

    // la propiedad $guarded hace el efecto contrario a $fillable
    // que campos no quiero que asigne a la asignaciones masiva
    protected $guarded = ['id', 'created_at', 'updated_at'];

    // relación uno a muchos products y sizes
    public function sizes(){
        return $this->hasMany(Size::class);
    }

    // relación uno a muchos inversa
    public function brand(){
        return $this->belongsTo(Brand::class);
    }

    // relación uno a muchos inversa
    public function subcategory(){
        return $this->belongsTo(Subcategory::class);
    }

    // relación muchos a muchos products con colors
    public function colors(){
        return $this->belongsToMany(Color::class);
    }

    // relación uno a muchos polimórfica
    public function images(){
        return $this->morphMany(Image::class, "imageable");
    }

}
```
Esto lo hicimos para que en un futuro podamos recordar que hacen las constantes que estamos almacenando en el campo status de la tabla products.

En database/factories/ProductFactory.php:
```php
<?php

namespace Database\Factories;

use App\Models\Product;
use App\Models\Subcategory;
use Illuminate\Support\Str;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {

        $name = $this->faker->sentence(2);

        // recuperar una subcategory al azar
        $subcategory = Subcategory::all()->random();
        // recuperar la categoría a la que pertenece esta subcategory
        $category = $subcategory->category;
        // recuperar la colección de marcas de esta categoría y escoger una al azar
        $brand = $category->brands->random();

        // En caso que color sea true en $subcategory NO almacenar quantity dejarla en NULL
        if ($subcategory->color) {
            $quantity = null;
        }else{
            $quantity = 15;
        }

        return [
            'name' => $name,
            'slug' => Str::slug($name),
            'description' => $this->faker->text(),
            'price' => $this->faker->randomElement([19.99, 49.99, 99.99]),
            'subcategory_id' => $subcategory->id,
            'brand_id' => $brand->id,
            'quantity' => $quantity,
            'status' => 2
        ];
    }
}
``` 

Ahora incluir el ProductFactory.php al seeder.
database/seeders/ProductSeeder.php:
```php
<?php

namespace Database\Seeders;

use App\Models\Product;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Product::factory(250)->create();
    }
}
```

Por ultimo incluir ProductSeeder en.
database/seeders/DatabaseSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Storage;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Storage::deleteDirectory('public/categories'); 
        Storage::deleteDirectory('public/subcategories');

        Storage::makeDirectory('public/categories'); 
        Storage::makeDirectory('public/subcategories');

        $this->call(UserSeeder::class);
        $this->call(CategorySeeder::class);
        $this->call(SubcategorySeeder::class);
        $this->call(ProductSeeder::class);
        
    }
}
```

Correr las migraciones para verificar que todo este funcionando correctamente:
- php artisan migrate:fresh --seed
Listo!
Ya funciono hasta aquí!
# 12. Insertar registros en la tabla colors
En database/seeders/ColorSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Color;

class ColorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $colors = ['white', 'blue', 'red', 'black'];

        foreach ($colors as $color) {
            Color::create([
                'name' => $color
            ]);
        }

    }
}
```

En database/seeders/DatabaseSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Storage;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Storage::deleteDirectory('public/categories'); 
        Storage::deleteDirectory('public/subcategories');

        Storage::makeDirectory('public/categories'); 
        Storage::makeDirectory('public/subcategories');

        $this->call(UserSeeder::class);
        $this->call(CategorySeeder::class);
        $this->call(SubcategorySeeder::class);

        $this->call(ProductSeeder::class);
        $this->call(ColorSeeder::class);
        $this->call(ColorProductSeeder::class);
        
    }
}
```

Ejecutar las migraciones con los seeders.
- php artisan migrate:fresh --seed
Listo!

Para poder relacionar la tabla colors con products necesitamos, crear un nuevo seeder ColorProductSeeder:
- php artisan make:seeder ColorProductSeeder

En  database/seeders/ColorProductSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use Illuminate\Database\Eloquent\Builder;
use App\Models\Product;

class ColorProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // consulta a las relaciones del modelo Product
        // nos regresara todos los productos solo si 
        // el color es true y size es false 
        $products = Product::whereHas('subcategory', function(Builder $query){
            $query->where('color', true)->where('size', false);
        })->get();

        // para introducir registros a la tabla intermedia color_product
        // cada uno de estos productos van a tener 4 colores, 10 de cada color
        foreach ($products as $product) {
            $product->colors()->attach([
                1 => [
                    'quantity' => 10
                ], 
                2 => [
                    'quantity' => 10
                ], 
                3 => [
                    'quantity' => 10
                ], 
                4 => [
                    'quantity' => 10
                ]
            ]);
        }        

    }
}
```

Ejecutar las migraciones con los seeders.
- php artisan migrate:fresh --seed
Listo!
Ya funciono hasta aquí.
# 13. Insertar registros en la tabla tallas







# 14. Descargar imágenes para los productos
