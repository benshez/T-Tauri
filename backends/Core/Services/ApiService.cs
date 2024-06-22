using TTauriCore.Interfaces;

namespace TTauriCore.Services;

public class ApiClient<T>(HttpClient httpClient) : IApiClient<T>
{
    private readonly HttpClient _httpClient = httpClient;

    public async Task<T> GetAsync(string url)
    {
        HttpResponseMessage response = await _httpClient.GetAsync(url);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsAsync<T>();
    }

    public async Task<T> PostAsync(string url, T item)
    {
        HttpResponseMessage response = await _httpClient.PostAsJsonAsync(url, item);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsAsync<T>();
    }

    public async Task<T> PutAsync(string url, T item)
    {
        HttpResponseMessage response = await _httpClient.PutAsJsonAsync(url, item);
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsAsync<T>();
    }

    public async Task DeleteAsync(string url)
    {
        HttpResponseMessage response = await _httpClient.DeleteAsync(url);
        response.EnsureSuccessStatusCode();
    }
}