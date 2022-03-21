# Path Relativo
Cursos/Victor Arana Flores/Ecommerce/Ecommerce.md

# Crea un Ecommerce con Laravel, Livewire, Tailwind y Alpine
Victor Arana Flores
@victoraranaflores
# Sección 1: Introducción
# 01. Programas necesarios
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








# 10. Insertar registros en la tabla brands
# 11. Insertar registros en la tabla products
# 12. Insertar registros en la tabla colors
# 13. Insertar registros en la tabla tallas
# 14. Descargar imágenes para los productos
