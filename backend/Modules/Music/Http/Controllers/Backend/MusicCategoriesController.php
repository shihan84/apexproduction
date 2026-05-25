<?php

namespace Modules\Music\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Modules\Music\Models\MusicCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class MusicCategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categories = MusicCategory::with(['user'])
            ->latest()
            ->paginate(20);

        return view('music::backend.categories.index', compact('categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('music::backend.categories.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
        ]);

        $validated['user_id'] = auth()->id();
        $validated['slug'] = Str::slug($validated['name']);

        MusicCategory::create($validated);

        return redirect()
            ->route('backend.music.categories.index')
            ->with('success', 'Category created successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(MusicCategory $category)
    {
        return view('music::backend.categories.edit', compact('category'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, MusicCategory $category)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
        ]);

        $validated['slug'] = Str::slug($validated['name']);

        $category->update($validated);

        return redirect()
            ->route('backend.music.categories.index')
            ->with('success', 'Category updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(MusicCategory $category)
    {
        $category->delete();

        return redirect()
            ->route('backend.music.categories.index')
            ->with('success', 'Category deleted successfully.');
    }
}
