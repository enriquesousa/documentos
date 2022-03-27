# Path Relativo
Cursos/Victor Arana Flores/Ecommerce/Ecommerce.md

# Crea un Ecommerce con Laravel, Livewire, Tailwind y Alpine
Victor Arana Flores
@victoraranaflores
# Sección 1: Introducción
## 01. Programas necesarios
- https://github.com/coders-free/ecommerce
## 02. Instalación
En htdocs
- laravel new ecommerce --jet
- npm install && npm run dev
## 03. Extensiones VSC
# Sección 2: Diseño de la base de datos
## 04. Maquinación de la bbdd
## 05. Maquinación de la bbdd 2
## 06. Modelo físico
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
## 07. Generar relaciones Eloquent
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
## 08. Insertar registros en la tabla categories
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
## 09. Insertar registros en la tabla subcategories
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
## 10. Insertar registros en la tabla brands
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
## 11. Insertar registros en la tabla products
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
## 12. Insertar registros en la tabla colors
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
## 13. Insertar registros en la tabla tallas
Crear nuevo seeder.
- php artisan make:seeder SizeSeeder 

En database/seeders/SizeSeeder.php:
```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use Illuminate\Database\Eloquent\Builder;
use App\Models\Product;

class SizeSeeder extends Seeder
{
    public function run()
    {

        $products = Product::whereHas('subcategory', function(Builder $query){
            $query->where('color', true)->where('size', true);
        })->get();

        $sizes = ['Talla S', 'Talla M', 'Talla L'];

        foreach ($products as $product) {

            // a cada product de la colección le asignamos las 3 tallas
            foreach ($sizes as $size) {
                $product->sizes()->create([
                    'name' => $size
                ]);
            }
            
        }
        
    }
}
```

Agregamos el nuevo seeder a.
database/seeders/DatabaseSeeder.php:
```php
$this->call(SizeSeeder::class);
```

Agregarle color y size a.
database/seeders/SubcategorySeeder.php:
```php
[
    'category_id' => 5,
    'name' => 'Mujeres',
    'slug' => Str::slug('Mujeres'),
    'color' => true,
    'size' => true
],
[
    'category_id' => 5,
    'name' => 'Hombres',
    'slug' => Str::slug('Hombres'),
    'color' => true,
    'size' => true
],
```

Ahora si, ejecutar las migraciones con los seeders.
- php artisan migrate:fresh --seed
Listo!
Ahora ya aparecen datos en la tabla sizes! 
## 14. Descargar imágenes para los productos
En database/factories/ImageFactory.php:
```php
<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Image>
 */
class ImageFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'url' => 'products/' . $this->faker->image('public/storage/products', 640, 480, null, false), // con false me regresa solo: imagen.jpg
        ];
    }
}
```

En database/seeders/ProductSeeder.php:
```php
<?php

namespace Database\Seeders;

use App\Models\Image;
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
        // por cada producto que creamos quiero 4 imágenes
        Product::factory(250)->create()->each(function (Product $product){
            Image::factory(4)->create([
                'imageable_id' => $product->id,
                'imageable_type' => Product::class,
            ]);
        });


    }
}
```

En database/seeders/DatabaseSeeder.php:
```php
Storage::deleteDirectory('public/products');

Storage::makeDirectory('public/products');
```

Ahora si, ejecutar las migraciones con los seeders.
- php artisan migrate:fresh --seed
Listo!
Se generaron 1000 imágenes en 
# Sección 4: Ajuste de estilos
## 15. Agregar colores
Para poder usar colores en tailwind agregar:
const colors = require('tailwindcss/colors');
a tailwind.config.js:
```php
const defaultTheme = require('tailwindcss/defaultTheme');
const colors = require('tailwindcss/colors');

module.exports = {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './vendor/laravel/jetstream/**/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
    ],

    theme: {
        extend: {

            fontFamily: {
                sans: ['Nunito', ...defaultTheme.fontFamily.sans],
            },

        },
    },

    plugins: [require('@tailwindcss/forms'), require('@tailwindcss/typography')],
};
```
Compilar con:
- npm run dev

Entrar a https://homestead.ecommerce/dashboard
con las credenciales
```php
enrique.sousa@gmail.com
sousa1234
```
En resources/views/dashboard.blade.php:
```php
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </x-slot>

    <div class="py-12">

        <h1 class="text-orange-500">Hola mundo!</h1>

        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <x-jet-welcome />
            </div>
        </div>
    </div>
</x-app-layout>
```
Listo!
Ya funciono.
## 16. Diseñar plantilla
Vemos que la vista:
- resources/views/dashboard.blade.php
El cual llama a la plantilla (componente de blade) <x-app-layout> que esta en:
- app/View/Components/AppLayout.php
el cual solo manda renderizar a:
- resources/views/layouts/app.blade.php
Este es el archivo base del cual podemos extender, en este caso el contenido del dashboard lo estamos colocando dentro de este archivo base en el contenido de la pagina con:
- {{ $slot }}
También podemos colocar slots con nombre, tal es el caso de:
- {{ $header }}
El cual se esta mandando llamar desde dashboard.blade.php con esta sintaxis.
- <x-slot name="header"> 
Si no le ponemos nombre, asume que es {{ $slot }}

Por otro lado vemos que en app.blade.php también es posible mandar llamar otro tipo de componentes como son componentes de livewire:
- @livewire('navigation-menu')

Nosotros vamos a crear nuestro propio menu de navegación y lo vamos a hacer dinámico usando un componente de livewire.
Para crear un componente livewire:
- php artisan make:livewire navigation

Esto nos creo dos archivos:
1. app/Http/Livewire/Navigation.php
2. resources/views/livewire/navigation.blade.php

Para poder crear nuestra propia clase de estar centrando el contenido vamos a crear.
resources/css/container.css:
```php
.container{
    @apply max-w-7xl mx-auto px-4 sm:px-6 lg:px-8;
}
```
Agregarlo a resources/css/app.css:
```php
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

@import 'container.css';
```

Compilar:
- npm run dev 

En resources/views/livewire/navigation.blade.php ya podemos usar la clase nueva que hicimos container:
```php
<header>
    <div class="container">
        Hola mundo
    </div>
</header>
```
Listo!
# Sección 5: Diseñando el header
## 17. Diseñando el header
En resources/views/livewire/navigation.blade.php:
```php
<header class="bg-gray-600">
    <div class="container flex items-center h-16">

        <a class="flex flex-col items-center justify-center px-4 bg-white bg-opacity-25 text-white cursor-pointer font-semibold h-16">
            <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                <path class="inline-flex" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>

            <span>
                Categorías
            </span>
        </a>

        <a href="/" class="ml-4">
            <x-jet-application-mark class="block h-9 w-auto" />
        </a>

        @livewire('search')

    </div>
</header>
```

6:47
Para crear los componentes jetstream.
If you are using the Livewire stack, you should first publish the Livewire stack's Blade components:
- php artisan vendor:publish --tag=jetstream-views
nos crea los componentes en:
resources/views/vendor/jetstream/components.

El componente que contiene el logotipo es:
resources/views/vendor/jetstream/components/application-mark.blade.php
Para mandar llamar logotipo lo hacemos asi:
<x-jet-application-mark />

Crear nuevo componente livewire search.
- php artisan make:livewire search

En resources/views/livewire/search.blade.php:
```php
<div class="flex-1">
    <x-jet-input type="text" class="ml-4 w-full" placeholder="Estas buscando algún producto?" />
</div>
```
Listo!
## 18. Incluir icono de lupa

6:41









## 19. Incluir dropdown
## 20. Incluir icono de carrito de compras
# Sección 6: Diseñar menu
## 21. Diseñar el menu
## 22. Diseñar el submenu I
## 23. Diseñar el submenu II
## 24. Agregar funcionalidades al menu I
## 25. Agregar funcionalidades al menu II
## 26. Menu responsivo I
## 27. Menu responsivo II
## 28. Menu responsivo III
## 29. Menu responsivo IV
# Sección 7: Slider
## 30. Incluir Glider js a nuestro proyecto
## 31. Slider de productos
## 32. Solucionar desface
## 33. Slider para todas las categorías
## 34. Agregando filtros
## 35. Solucionar errores con el slider
## 36. Slider responsivo
# Sección 8: Categorías
## 37. Crear rutas para categorías
## 38. Detalle de categoría
## 39. Agregar filtros I
## 40. Agregar filtros II
## 41. Mostrar productos en forma de grid y lista
## 42. Volver vista responsiva
# Sección 9: Products
## 43. Crear ruta de productos
## 44. Incluir plugin FlexSlider
## 45. Diseño vista detalle producto
## 46. Traducir fechas
## 47. Stock Productos
## 48. Habilitar Deshabilitar botones
## 49. Traer colores de productos
## 50. Stock productos con color
## 51. Agregar colores para producto con tallas
## 52. Mostrar tallas y colores
## 53. Traducir nuestra aplicación
## 54. Stock tallas
# Sección 10: Carrito de compras
## 55. Instalar shopping cart
## 56. Agregar items al carrito de compra
## 57. Mostrar item en el carrito de compra I
## 58. Mostrar item en el carrito de compra II
## 59. Mostrar cantidad en el carrito de compras
## 60. Agregar item con color al carrito
## 61. Agregar item con talla al carrito
## 62. Helpers
## 63. Dompautolad
## 64. Utilizar los helpers
## 65. Nuevos modelos
## 66. Mostrando stock de productos
# Sección 11: Buscador
## 67. Diseñar buscador I
## 68. Diseñar buscador II
## 69. Apuntar a un producto
## 70. Mostrar resultado de búsqueda I
## 71. Mostrar resultado de búsqueda II
# Sección 12: Shopping cart
## 72. Crear ruta de shopping cart
## 73. Diseño vista shopping cart I
## 74. Diseño vista shopping cart II
## 75. Habilitar botones I
## 76. Habilitar botones II
## 77. Habilitar botones III
## 78. Detalle de producto
## 79. Destruir carrito de compras
## 80. Detalle carrito de compras
## 81. Eliminar producto
# Sección 13: Crear ordenes
## 82. Crear ruta para nuevas ordenes
## 83. Generar eventos y oyentes
## 84. Agregar lógica en los oyentes
## 85. Crear las tablas necesarias
## 86. Agregar campos
## 87. Corregir errores
## 88. Crear relaciones
## 89. Llenar con datos falsos
## 90. Crear la vista para crear una orden I
## 91. Crear la vista para crear una orden II
## 92. Interactuar Alpine con Livewire
## 93. Crear ordenes I
## 93. Crear ordenes II
## 93. Crear ordenes III
## 93. Crear ordenes IV
## 97. Generar vista de resumen de orden
# Sección 14: Mercado de pago
## 98. Obtener credenciales de mercado pago
## 99. Instalar SDK de mercado pago
## 100. Checkout Mercado Pago
## 101. Simular un pago
## 102. Credenciales de producción
## 103. Webhook
## 104. Obtener un pago
## 105. Incluir costos de envío
# Sección 15: Pasarela de pago PayPal
## 106. Modificar la vista de Payment
## 107. Credenciales de PayPal
## 108. Checkout PayPal
## 109. Cambiar status de orden
# Sección 16: Administrar ordenes
## 110. Detalle de ordenes
## 111. Agregar políticas de acceso
## 112. Ruta para mostrar nuestras ordenes
## 113. Detalle de mis ordenes I
## 114. Detalle de mis ordenes II
## 115. Filtrar ordenes por status
## 116. Avisar que tienes ordenes pendientes
## 117. Solucionar un pequeño error
## 118. Descontar stock
## 119. Anular ordenes
## 120. Programar tareas
# Sección 17: Agregar productos
## 121. Crear ruta de administrador
## 122. Mostrar productos I
## 123. Mostrar productos II
## 124. Habilitar buscador
## 125. Vista crear productos I
## 126. Vista crear productos II
## 127. Vista crear productos III
## 128. Vista crear productos IV
## 129. Reglas de validación
## 130. Agregar registro a la BBDD
# Sección 18: Editar productos
## 131. Crear ruta de edición 
## 132. Crear formulario de edición 
## 133. Solucionar algunos errores
## 134. Actualizar producto
## 135. Agregar componente de color y talla
# Sección 19: Componente color product
## 136. Crear formulario
## 137. Agregar productos con color
## 138. Actualizar registro I
## 139. Actualizar registro II
## 140. Actualizar registro III
## 141. Eliminar registro
# Sección 20: Componente size product
## 142. Agregar talla
## 143. Actualizar talla
## 144. Eliminar talla
## 145. Agregar color a talla
## 146. Editar color de talla
## 147. Eliminar talla
## 148. Solucionar errores
# Sección 21: Subir imágenes
## 149. Subir imágenes con Dropzone
## 150. Mostrar y eliminar imágenes
## 151. Solucionar error
## 152. Refrescar imágenes
## 153. Solucionar error
## 154. Eliminar datos sobrantes
# Sección 22: Detalles finales
## 155. Cambiar status del producto
## 156. Eliminar productos
## 157. Modificar plantilla admin
# Sección 23: Categorías
## 158. Formulario crear categorías
## 159. Reglas de validación
## 160. Crear categorías
## 161. Mostrar categorías
## 162. Eliminar categorías
## 163. Editar categorías I
## 164. Editar categorías II
## 165. Editar categorías III
## 166. Editar categorías IV
## 167. Detalle de categoría
# Sección 24: Subcategoría
## 168. Modificar Subcategoría en la vista comprador
## 169. Mostrar subcategorías
## 170. Crud subcategorías
# Sección 25: Cruds finales
## 171. Crud marcas
# Sección 26: Ordenes
## 172. Mostrar ordenes
## 173. Administrar ordenes
# Sección 27: Envíos
## 174. Crud de departamentos I
## 175. Crud de departamentos II
## 176. Crud de ciudades
## 177. Crud de distritos I
## 178. Crud de distritos II
## 179. Modificar migraciones
## 180. Eliminar datos de envió
# Sección 28: Laravel Permission
## 181. Instalar Laravel Permission
## 182. Crear Crud para usuarios
## 183. Mostrar listado de usuarios
## 184. Agregar buscador
## 185. Asignar rol
# Sección 29: Diseño responsivo
## 186. Diseño responsivo 1
## 187. Diseño responsivo 2
## 188. Diseño responsivo 3
## 189. Diseño responsivo 4
## 190. Diseño responsivo 5
## 191. Diseño responsivo 6
# Sección 30: Reseñas
## 192. Formulario de reseñas
## 193. Mostrar formulario a personas que compraron el producto
## 194. Almacenar reseña
## 195. Mostrar reseñas
